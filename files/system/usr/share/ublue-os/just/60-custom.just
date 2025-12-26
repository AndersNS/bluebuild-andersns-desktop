# Custom just commands for bluebuild-andersns-desktop

# Update to the latest custom image from GitHub
update-custom:
    #!/usr/bin/env bash
    echo "Updating to latest custom image..."
    rpm-ostree update
    echo ""
    echo "Update complete! Reboot to apply changes:"
    echo "  systemctl reboot"

# Full system update (base + custom image + flatpaks)
update-all:
    #!/usr/bin/env bash
    echo "==> Updating custom BlueBuild image..."
    rpm-ostree update
    echo ""
    echo "==> Updating Flatpaks..."
    flatpak update -y
    echo ""
    echo "==> Updates complete! Reboot to apply changes:"
    echo "  systemctl reboot"

# Reset configs to fresh defaults (as if new user)
reset-configs:
    #!/usr/bin/env bash
    echo "This will reset your Hyprland, Alacritty, Kitty, Foot, Waybar, and Wofi configs to defaults."
    echo "WARNING: Current configs will be deleted (no backup)."
    echo ""
    read -p "Continue? [y/N] " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Cancelled."
        exit 0
    fi
    
    # Remove existing configs and marker
    echo "Removing current configs..."
    rm -rf "$HOME/.config/hypr"
    rm -rf "$HOME/.config/alacritty"
    rm -rf "$HOME/.config/kitty"
    rm -rf "$HOME/.config/foot"
    rm -rf "$HOME/.config/waybar"
    rm -rf "$HOME/.config/wofi"
    rm -f "$HOME/.config/.skel-configs-copied"
    
    # Recreate empty directories
    echo "Creating fresh directories..."
    mkdir -p "$HOME/.config/hypr"
    mkdir -p "$HOME/.config/alacritty"
    mkdir -p "$HOME/.config/kitty"
    mkdir -p "$HOME/.config/foot"
    mkdir -p "$HOME/.config/waybar"
    mkdir -p "$HOME/.config/wofi"
    
    # Copy fresh configs from skel
    echo "Copying fresh configs..."
    cp -r /usr/etc/skel/.config/hypr/* "$HOME/.config/hypr/"
    cp -r /usr/etc/skel/.config/alacritty/* "$HOME/.config/alacritty/"
    cp -r /usr/etc/skel/.config/kitty/* "$HOME/.config/kitty/"
    cp -r /usr/etc/skel/.config/foot/* "$HOME/.config/foot/"
    cp -r /usr/etc/skel/.config/waybar/* "$HOME/.config/waybar/"
    cp -r /usr/etc/skel/.config/wofi/* "$HOME/.config/wofi/"
    
    # Mark as setup
    touch "$HOME/.config/.skel-configs-copied"
    
    echo ""
    echo "✓ Configs reset to defaults!"
    echo ""
    echo "Restart Hyprland to apply changes:"
    echo "  Log out and log back in, or run: hyprctl reload"
