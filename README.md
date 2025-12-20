# bluebuild-andersns-desktop &nbsp; [![bluebuild build badge](https://github.com/andersns/bluebuild-andersns-desktop/actions/workflows/build.yml/badge.svg)](https://github.com/andersns/bluebuild-andersns-desktop/actions/workflows/build.yml)

A custom Fedora Atomic image for gaming and development, built with [BlueBuild](https://blue-build.org/).

## What's Included

### Gaming (from Bazzite)

- Steam with Proton
- Lutris
- MangoHud (performance overlay)
- Gamescope (gaming compositor)
- HDR support
- fsync kernel for better gaming performance

### Desktop (Hyprland)

- hyprland, hyprpaper, hyprlock, hypridle
- waybar (status bar)
- wofi (app launcher)
- swaync (notifications)
- wlogout (logout menu)
- foot (terminal)
- thunar (file manager)

### Development

- Nix package manager (pre-installed)

## Installation

> [!WARNING]
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable), try at your own discretion.

To rebase an existing atomic Fedora installation to the latest build:

1. **Rebase to the unsigned image** (to get signing keys):

   ```bash
   rpm-ostree rebase ostree-unverified-registry:ghcr.io/andersns/bluebuild-andersns-desktop:latest
   ```

2. **Reboot**:

   ```bash
   systemctl reboot
   ```

3. **Rebase to the signed image**:

   ```bash
   rpm-ostree rebase ostree-image-signed:docker://ghcr.io/andersns/bluebuild-andersns-desktop:latest
   ```

4. **Reboot again**:
   ```bash
   systemctl reboot
   ```

## Using Nix

Nix is pre-installed. Install dev tools directly:

```bash
# Install packages
nix profile install nixpkgs#neovim nixpkgs#nodejs nixpkgs#rustup

# Search packages
nix search nixpkgs ripgrep

# Update packages
nix profile upgrade '.*'
```

## Keybindings (Hyprland)

| Key                   | Action                   |
| --------------------- | ------------------------ |
| `Super + Return`      | Terminal (foot)          |
| `Super + Space`       | App launcher (wofi)      |
| `Super + Q`           | Close window             |
| `Super + E`           | File manager             |
| `Super + F`           | Fullscreen               |
| `Super + V`           | Toggle floating          |
| `Super + 1-0`         | Switch workspace         |
| `Super + Shift + 1-0` | Move window to workspace |
| `Super + Shift + L`   | Lock screen              |
| `Super + Shift + E`   | Logout menu              |
| `Print`               | Screenshot (area)        |
| `Shift + Print`       | Screenshot (full)        |

## ISO

If building on Fedora Atomic, you can generate an offline ISO with the instructions available [here](https://blue-build.org/learn/universal-blue/#fresh-install-from-an-iso).

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by running:

```bash
cosign verify --key cosign.pub ghcr.io/andersns/bluebuild-andersns-desktop
```

## Customization

- **Hyprland config**: `~/.config/hypr/hyprland.conf`
- **Waybar config**: `~/.config/waybar/config` and `style.css`
- **Alacritty config**: `~/.config/alacritty/alacritty.toml`

## Credits

- [Bazzite](https://bazzite.gg/) - Gaming-focused Fedora Atomic
- [BlueBuild](https://blue-build.org/) - Custom image builder
- [Universal Blue](https://universal-blue.org/) - Fedora Atomic ecosystem
- [Hyprland](https://hyprland.org/) - Wayland compositor
- [Nix](https://nixos.org/) - Reproducible package manager
