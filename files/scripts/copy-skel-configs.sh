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

# Copy Foot config if it doesn't exist
if [ ! -f "$HOME/.config/foot/foot.ini" ]; then
    echo "Copying Foot config..."
    mkdir -p "$HOME/.config/foot"
    cp -r /usr/etc/skel/.config/foot/* "$HOME/.config/foot/"
fi

# Copy Wofi config if it doesn't exist
if [ ! -f "$HOME/.config/wofi/config" ]; then
    echo "Copying Wofi config..."
    mkdir -p "$HOME/.config/wofi"
    cp -r /usr/etc/skel/.config/wofi/* "$HOME/.config/wofi/"
fi

# Copy Kitty config if it doesn't exist
if [ ! -f "$HOME/.config/kitty/kitty.conf" ]; then
    echo "Copying Kitty config..."
    mkdir -p "$HOME/.config/kitty"
    cp -r /usr/etc/skel/.config/kitty/* "$HOME/.config/kitty/"
fi

# Always ensure hyprpaper.conf exists (required for wallpaper)
if [ ! -f "$HOME/.config/hypr/hyprpaper.conf" ]; then
    echo "Copying hyprpaper config..."
    mkdir -p "$HOME/.config/hypr"
    cp /usr/etc/skel/.config/hypr/hyprpaper.conf "$HOME/.config/hypr/hyprpaper.conf"
fi

# Always ensure hyprlock.conf exists (required for lockscreen)
if [ ! -f "$HOME/.config/hypr/hyprlock.conf" ]; then
    echo "Copying hyprlock config..."
    mkdir -p "$HOME/.config/hypr"
    cp /usr/etc/skel/.config/hypr/hyprlock.conf "$HOME/.config/hypr/hyprlock.conf"
fi

# Mark as completed
touch "$MARKER_FILE"
echo "Skel configs copied successfully"
