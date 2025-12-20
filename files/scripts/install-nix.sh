#!/usr/bin/env bash

# Install Nix using Determinate Nix Installer
# This runs during image build time (no systemd available)

set -oue pipefail

echo "Installing Nix via Determinate Nix Installer..."

# Download and run the Determinate Nix Installer for Linux
# --no-confirm: non-interactive mode for CI/build environments
# --init none: no init system during container build (systemd not available)
# Note: When booted, the ostree system will handle Nix daemon via systemd
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
    sh -s -- install linux --no-confirm --init none

echo "Nix installation completed successfully"
