#!/usr/bin/env bash
# Customize OS release information

set -oue pipefail

echo "Customizing OS release information..."

# Modify /usr/lib/os-release
sed -i 's/^NAME=.*/NAME="AndersNS Desktop"/' /usr/lib/os-release
sed -i 's/^PRETTY_NAME=.*/PRETTY_NAME="AndersNS Desktop 42 (Hyprland Gaming Edition)"/' /usr/lib/os-release
sed -i 's/^DEFAULT_HOSTNAME=.*/DEFAULT_HOSTNAME="andersns-desktop"/' /usr/lib/os-release
sed -i 's|^HOME_URL=.*|HOME_URL="https://github.com/AndersNS/bluebuild-andersns-desktop"|' /usr/lib/os-release
sed -i 's|^BUG_REPORT_URL=.*|BUG_REPORT_URL="https://github.com/AndersNS/bluebuild-andersns-desktop/issues"|' /usr/lib/os-release

# Add variant if not present
if ! grep -q "^VARIANT=" /usr/lib/os-release; then
    echo 'VARIANT="Hyprland Gaming Edition"' >> /usr/lib/os-release
    echo 'VARIANT_ID=hyprland' >> /usr/lib/os-release
fi

echo "OS release customization complete"
