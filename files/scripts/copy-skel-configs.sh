#!/bin/bash
# Copy skel configs to existing users' home directories
# This runs on first login for existing users who upgraded to this image

MARKER_FILE="$HOME/.config/.skel-configs-copied"

# Skip if already copied
if [ -f "$MARKER_FILE" ]; then
    exit 0
fi

# Create config directory if it doesn't exist
mkdir -p "$HOME/.config"

# Copy Hyprland config if it doesn't exist
if [ ! -f "$HOME/.config/hypr/hyprland.conf" ]; then
    echo "Copying Hyprland config..."
    mkdir -p "$HOME/.config/hypr"
    cp -r /usr/etc/skel/.config/hypr/* "$HOME/.config/hypr/"
fi

# Copy Alacritty config if it doesn't exist
if [ ! -f "$HOME/.config/alacritty/alacritty.toml" ]; then
    echo "Copying Alacritty config..."
    mkdir -p "$HOME/.config/alacritty"
    cp -r /usr/etc/skel/.config/alacritty/* "$HOME/.config/alacritty/"
fi

# Copy Waybar config if it doesn't exist
if [ ! -d "$HOME/.config/waybar" ]; then
    echo "Copying Waybar config..."
    mkdir -p "$HOME/.config/waybar"
    cp -r /usr/etc/skel/.config/waybar/* "$HOME/.config/waybar/"
fi

# Mark as completed
touch "$MARKER_FILE"
echo "Skel configs copied successfully"
