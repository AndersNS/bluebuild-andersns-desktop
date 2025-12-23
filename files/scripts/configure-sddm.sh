#!/usr/bin/env bash

# Configure SDDM as the display manager for Hyprland

set -oue pipefail

echo "Configuring SDDM..."

# Enable SDDM service (Bazzite default)
systemctl enable sddm.service

# Disable GDM if it exists
systemctl disable gdm.service 2>/dev/null || true

echo "SDDM configuration complete"
