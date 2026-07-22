#!/usr/bin/env bash
set -euo pipefail

WALLPAPER_DIR="${HOME}/.config/okoko/wallpapers"
STATE_FILE="${HOME}/.config/okoko/current_background"

[[ -d "$WALLPAPER_DIR" ]] || exit 1

mapfile -d '' -t WALLPAPERS < <(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) -print0 | sort -z)

TOTAL=${#WALLPAPERS[@]}
(( TOTAL == 0 )) && exit 1

CURRENT=""
[[ -f "$STATE_FILE" ]] && CURRENT=$(<"$STATE_FILE")

NEXT_INDEX=0
for i in "${!WALLPAPERS[@]}"; do
    if [[ "${WALLPAPERS[$i]}" == "$CURRENT" ]]; then
        NEXT_INDEX=$(( (i + 1) % TOTAL ))
        break
    fi
done

NEXT="${WALLPAPERS[$NEXT_INDEX]}"

feh --bg-fill "$NEXT"
printf '%s\n' "$NEXT" > "$STATE_FILE"
