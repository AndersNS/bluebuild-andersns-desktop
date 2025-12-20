# Custom just commands for bluebuild-andersns-desktop

# Update to the latest custom image from GitHub
update-custom:
    #!/usr/bin/env bash
    set -euo pipefail
    echo "Checking for custom image updates..."
    if rpm-ostree rebase ostree-unverified-registry:ghcr.io/andersns/bluebuild-andersns-desktop:latest 2>&1 | grep -q "old and new refs are equal"; then
        echo "Already on the latest custom image version!"
    else
        echo ""
        echo "Update downloaded! Reboot to apply changes:"
        echo "  systemctl reboot"
    fi

# Full system update (base + custom image + flatpaks)
update-all:
    #!/usr/bin/env bash
    set -euo pipefail
    echo "==> Checking for custom BlueBuild image updates..."
    if rpm-ostree rebase ostree-unverified-registry:ghcr.io/andersns/bluebuild-andersns-desktop:latest 2>&1 | grep -q "old and new refs are equal"; then
        echo "Already on the latest custom image version"
    else
        echo "Custom image updated!"
    fi
    echo ""
    echo "==> Updating Flatpaks..."
    flatpak update -y
    echo ""
    echo "==> Updates complete!"
    rpm-ostree status | grep -q "pending" && echo "Reboot to apply system changes: systemctl reboot" || echo "No system reboot needed"
