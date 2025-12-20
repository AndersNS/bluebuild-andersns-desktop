#!/usr/bin/env bash

# Configure SDDM as the display manager for Hyprland

set -oue pipefail

echo "Configuring SDDM..."

# Enable SDDM service
systemctl enable sddm.service

# Disable GDM if it exists
systemctl disable gdm.service 2>/dev/null || true

# Create SDDM configuration for Wayland session
mkdir -p /etc/sddm.conf.d

cat > /etc/sddm.conf.d/wayland.conf << 'EOF'
[General]
DisplayServer=wayland
GreeterEnvironment=QT_WAYLAND_SHELL_INTEGRATION=layer-shell

[Wayland]
SessionDir=/usr/share/wayland-sessions
EOF

echo "SDDM configuration complete"
