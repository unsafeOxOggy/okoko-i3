#!/usr/bin/env bash
set -euo pipefail

# Reload Alacritty terminal instances
killall -q -USR1 alacritty || true

# Reload Dunst notification service
killall -q dunst && dunst &

# Restart i3 in-place via IPC
i3-msg restart
