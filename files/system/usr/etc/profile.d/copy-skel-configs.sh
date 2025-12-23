#!/bin/bash
# Auto-copy skel configs for existing users on first login

MARKER_FILE="$HOME/.config/.skel-configs-copied"

# Skip if already copied or if /usr/etc/skel doesn't exist
if [ -f "$MARKER_FILE" ] || [ ! -d "/usr/etc/skel/.config" ]; then
  return 0 2>/dev/null || exit 0
fi

# Create config directory if it doesn't exist
mkdir -p "$HOME/.config" 2>/dev/null

# Copy Hyprland config if it doesn't exist
if [ ! -f "$HOME/.config/hypr/hyprland.conf" ] && [ -d "/usr/etc/skel/.config/hypr" ]; then
  mkdir -p "$HOME/.config/hypr" 2>/dev/null
  cp -r /usr/etc/skel/.config/hypr/* "$HOME/.config/hypr/" 2>/dev/null
fi

# Always ensure env.conf exists (required by hyprland.conf source directive)
if [ ! -f "$HOME/.config/hypr/env.conf" ] && [ -f "/usr/etc/skel/.config/hypr/env.conf" ]; then
  mkdir -p "$HOME/.config/hypr" 2>/dev/null
  cp /usr/etc/skel/.config/hypr/env.conf "$HOME/.config/hypr/env.conf" 2>/dev/null
fi

# Copy Alacritty config if it doesn't exist
if [ ! -f "$HOME/.config/alacritty/alacritty.toml" ] && [ -d "/usr/etc/skel/.config/alacritty" ]; then
  mkdir -p "$HOME/.config/alacritty" 2>/dev/null
  cp -r /usr/etc/skel/.config/alacritty/* "$HOME/.config/alacritty/" 2>/dev/null
fi

# Copy Waybar config if it doesn't exist
if [ ! -d "$HOME/.config/waybar" ] && [ -d "/usr/etc/skel/.config/waybar" ]; then
  mkdir -p "$HOME/.config/waybar" 2>/dev/null
  cp -r /usr/etc/skel/.config/waybar/* "$HOME/.config/waybar/" 2>/dev/null
fi

# Copy Kitty config if it doesn't exist
if [ ! -f "$HOME/.config/kitty/kitty.conf" ] && [ -d "/usr/etc/skel/.config/kitty" ]; then
  mkdir -p "$HOME/.config/kitty" 2>/dev/null
  cp -r /usr/etc/skel/.config/kitty/* "$HOME/.config/kitty/" 2>/dev/null
fi

# Mark as completed
touch "$MARKER_FILE" 2>/dev/null
