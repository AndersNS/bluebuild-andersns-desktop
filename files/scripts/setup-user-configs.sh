#!/usr/bin/env bash
# Make the user config setup scripts executable

set -oue pipefail

chmod +x /usr/share/ublue-os/setup-user-configs.sh
chmod +x /usr/share/ublue-os/setup-hyprland-env.sh

echo "User config setup scripts installed"
