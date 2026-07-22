# okoko-i3 | Modular i3wm Desktop Environment

A lightweight, high-performance, and aesthetically consistent i3wm desktop environment tailored for virtualized environments and Linux hosts. Built with Polybar, Alacritty, Picom, and Rofi.

## Overview
<img width="1918" height="1078" alt="2026-07-22_08-13" src="https://github.com/user-attachments/assets/b2918c61-53da-4cd7-91f1-1b95a03dfbad" />

* **Window Manager**: `i3-gaps` / `i3wm`
* **Bar**: `Polybar` (Modular layout)
* **Terminal**: `Alacritty` (GPU/Software rendering, TOML config)
* **Launcher**: `Rofi` (Catppuccin Mocha theme with Vim navigation)
* **Compositor**: `Picom` (VM-optimized XRender / GLX rendering)
* **Wallpaper Manager**: `feh` (Automated cycling & persistence)
* **Screenshots**: `Flameshot` (GUI & CLI bindings)
* **Typography**: `RobotoMono Nerd Font` & `Font Awesome 6`

---

## Prerequisites

* **Operating System**: Debian 12+, Ubuntu 22.04+, or Kali Linux
* **Privileges**: Non-root user with `sudo` access
* **Utilities**: `git`, `curl`, `wget`

---

## Start

Clone the repository and execute the automated deployment script:

```bash
git clone https://github.com/unsafeOxOggy/okoko-i3.git
cd okoko-i3
chmod +x install.sh
./install.sh
````

### Post-Installation

1. Log out or reboot the system.
2. At the Display Manager (GDM/LightDM), select **i3** as your session.
3. Log in and launch your terminal using `$mod+Return`.
    

## Keybindings Reference

The default `$mod` key is set to **`Mod4` (`Super`)**.

### Window & Workspace Management

| **Shortcut**                   | **Action**                                |
| ------------------------------ | ----------------------------------------- |
| `$mod + Return`                | Open Alacritty terminal                   |
| `$mod + Space`                 | Launch Rofi application menu              |
| `$mod + w`                     | Close focused window (`WM_DELETE_WINDOW`) |
| `$mod + h / j / k / l`         | Focus window (Vim directionals)           |
| `$mod + Shift + h / j / k / l` | Move window (Vim directionals)            |
| `$mod + 1 .. 0`                | Switch to workspace 1–10                  |
| `$mod + Shift + 1 .. 0`        | Move focused window to workspace 1–10     |
| `$mod + Shift + r`             | Reload/Restart i3wm in-place              |
| `Print`                        | Open Flameshot interactive screenshot GUI |
| `$mod + q`                     | Cycle background wallpaper                |

### Alacritty Terminal Shortcuts

|**Shortcut**|**Action**|
|---|---|
|`Ctrl + Shift + c`|Copy selection to clipboard|
|`Ctrl + Shift + v`|Paste from clipboard|
|`Ctrl + Shift + Space`|Toggle Vi selection mode|
|`Ctrl + Shift + f / b`|Search buffer forward / backward|
|`Ctrl + + / -`|Increase / Decrease font size|

## Repository Structure

Plaintext

```
.
├── config/
│   ├── alacritty/
│   │   └── alacritty.toml         # Alacritty configuration & colors
│   ├── i3/
│   │   └── config                 # Core i3wm keybindings & startup rules
│   └── okoko/
│       ├── picom/
│       │   └── picom.conf         # Compositor settings (VM/XRender optimized)
│       ├── polybar/
│       │   ├── config.ini         # Polybar modules & bar parameters
│       │   └── launch.sh          # Bar initialization script
│       ├── rofi/
│       │   └── config.rasi        # Application launcher theme & layout
│       ├── scritps/
│       │   ├── reload_env.sh      # Environment reload daemon script
│       │   ├── spice-vdagent.sh   # VM guest agent integration
│       │   └── wallpaper.sh       # Feh background rotation logic
│       └── wallpapers/            # Custom wallpaper directory
└── install.sh                     # Automated deployment script
```

## Configuration Details

- **Picom Optimization**: Defaults to `xrender` backend to prevent X11 rendering artifacts and lag in virtualized hypervisors.
- **Polybar Integration**: Uses modular structure with explicit glyph fallbacks for system resources, workspace state, and network metrics.
- **State Persistence**: Wallpaper selection persists across reboots via synchronized state files and standard `~/.fehbg` hooks.
