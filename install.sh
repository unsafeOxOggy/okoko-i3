#!/usr/bin/env bash

set -euo pipefail

# ─── Color Definitions ────────────────────────────────────────────────────────
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m'

# ─── Logging Functions ────────────────────────────────────────────────────────
log_info()  { printf "${GREEN}[INFO]${NC} %s\n" "$1"; }
log_warn()  { printf "${YELLOW}[WARN]${NC} %s\n" "$1"; }
log_error() { printf "${RED}[ERROR]${NC} %s\n" "$1"; }

# ─── Ephemeral Cleanup Trap ---------------------------------------------------
# Guarantees removal of temporary download directories on exit or signal interruption
TMP_DIR=""
cleanup() {
    if [[ -n "${TMP_DIR:-}" && -d "$TMP_DIR" ]]; then
        rm -rf "$TMP_DIR"
    fi
}
trap cleanup EXIT INT TERM

# ─── Execution Context Validation ─────────────────────────────────────────────
if [[ ! -d "config" ]]; then
    log_error "'config/' directory not found in current execution path."
    log_error "Execute this script from the root of the configuration repository."
    exit 1
fi

# ─── Core Dependencies Installation ──────────────────────────────────────────
log_info "Updating APT cache and installing system dependencies..."
sudo apt-get update -qq
sudo apt-get install -y --no-install-recommends \
    i3 \
    polybar \
    picom \
    alacritty \
    feh \
    rofi \
    fonts-font-awesome \
    flameshot \
    wget \
    tar \
    fontconfig

# ─── Automated Nerd Fonts Deployment ─────────────────────────────────────────
log_info "Fetching and installing RobotoMono Nerd Font..."
NERD_FONT_VERSION="v3.3.0"
FONT_TARGET_DIR="${HOME}/.local/share/fonts"

# Create isolated temporary directory
TMP_DIR=$(mktemp -d)

mkdir -p "$FONT_TARGET_DIR"
wget -q --show-progress -O "${TMP_DIR}/RobotoMono.tar.xz" \
    "https://github.com/ryanoasis/nerd-fonts/releases/download/${NERD_FONT_VERSION}/RobotoMono.tar.xz"

tar -xf "${TMP_DIR}/RobotoMono.tar.xz" -C "$FONT_TARGET_DIR"

log_info "Refreshing X11 font cache..."
fc-cache -f "$FONT_TARGET_DIR"

# ─── Directory Structure Initialization ───────────────────────────────────────
log_info "Constructing configuration directory tree..."
mkdir -p \
    "${HOME}/.config/i3" \
    "${HOME}/.config/alacritty" \
    "${HOME}/.config/okoko/polybar" \
    "${HOME}/.config/okoko/picom" \
    "${HOME}/.config/rofi" \
    "${HOME}/.config/okoko/wallpapers" \
    "${HOME}/.config/okoko/scritps"

# ─── Configuration Artifact Deployment ──────────────────────────────────────
log_info "Deploying application configuration files..."

# Flat configuration files
cp -f "config/i3/config"                  "${HOME}/.config/i3/config"
cp -f "config/rofi/config.rasi"    "${HOME}/.config/rofi/config.rasi"
cp -f "config/okoko/picom/picom.conf"    "${HOME}/.config/okoko/picom/picom.conf"
cp -f "config/alacritty/alacritty.toml"  "${HOME}/.config/alacritty/alacritty.toml"

# Directory tree synchronization (preserves nested structure)
cp -rf config/okoko/polybar/*             "${HOME}/.config/okoko/polybar/" 2>/dev/null || true
cp -rf config/okoko/wallpapers/*          "${HOME}/.config/okoko/wallpapers/" 2>/dev/null || true
cp -rf config/okoko/scritps/*            "${HOME}/.config/okoko/scritps/" 2>/dev/null || true

# ─── Dynamic Permissions Enforcement ──────────────────────────────────────────
log_info "Recursively granting execution bits to shell scripts..."
find "${HOME}/.config/okoko/scritps" "${HOME}/.config/okoko/polybar" -type f -name "*.sh" -exec chmod +x {} +

log_info "Environment deployment completed successfully."
