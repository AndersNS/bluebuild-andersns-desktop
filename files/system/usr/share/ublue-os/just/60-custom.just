# Custom just commands for bluebuild-andersns-desktop

# Update to the latest custom image from GitHub
update-custom:
    #!/usr/bin/env bash
    set -euo pipefail
    echo "Updating to latest bluebuild-andersns-desktop image..."
    rpm-ostree rebase ostree-unverified-registry:ghcr.io/andersns/bluebuild-andersns-desktop:latest
    echo ""
    echo "Update downloaded! Reboot to apply changes:"
    echo "  systemctl reboot"

# Full system update (base + custom image + flatpaks)
update-all:
    #!/usr/bin/env bash
    set -euo pipefail
    echo "==> Updating custom BlueBuild image..."
    rpm-ostree rebase ostree-unverified-registry:ghcr.io/andersns/bluebuild-andersns-desktop:latest
    echo ""
    echo "==> Updating Flatpaks..."
    flatpak update -y
    echo ""
    echo "==> All updates complete! Reboot to apply system changes:"
    echo "  systemctl reboot"
