#!/bin/bash
# Setup Hyprland environment variables based on hardware
# This runs before Hyprland starts

HYPR_ENV_FILE="$HOME/.config/hypr/env.conf"

# Create config directory
mkdir -p "$HOME/.config/hypr"

# Detect if NVIDIA GPU is present
if lspci | grep -i nvidia | grep -i vga > /dev/null 2>&1; then
    # NVIDIA GPU detected - use NVIDIA-specific settings
    cat > "$HYPR_ENV_FILE" << 'NVIDIA_EOF'
# NVIDIA-specific settings (auto-detected)
env = LIBVA_DRIVER_NAME,nvidia
env = GBM_BACKEND,nvidia-drm
env = __GLX_VENDOR_LIBRARY_NAME,nvidia
env = NVD_BACKEND,direct
env = WLR_NO_HARDWARE_CURSORS,1
NVIDIA_EOF
else
    # No NVIDIA GPU - use generic settings
    cat > "$HYPR_ENV_FILE" << 'GENERIC_EOF'
# Generic Wayland settings (no NVIDIA detected)
# Using default drivers
GENERIC_EOF
fi

# Always set these
cat >> "$HYPR_ENV_FILE" << 'COMMON_EOF'
# Common settings
env = XDG_SESSION_TYPE,wayland
env = KITTY_ENABLE_WAYLAND,1
COMMON_EOF
