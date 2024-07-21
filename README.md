# NixOS Configuration

A comprehensive NixOS and Home Manager configuration leveraging Nix flakes for a personalized desktop environment.

## Description

This repository contains a detailed NixOS system configuration and Home Manager setup, designed for a personal desktop environment named "megaman". To be added: sonic (macOS), bomberman (homelab) and donkeykong (cloud server). It utilizes Nix flakes for reproducible builds and easy management of system and user-level packages and settings.

## Features

- Modular NixOS system configuration
- Home Manager integration for user environment management
- GNOME desktop environment with customizations
- Development tools setup (VSCode, Git, Go, Rust)
- Virtualization support (QEMU, libvirt, Docker)
- Tailscale VPN integration
- ZFS filesystem support
- Custom font configuration
- Theme management with Stylix
- Networking setup for multiple interfaces
- Hardware-specific optimizations

## Project Structure

```
nix-configs/
├── flake.nix
├── flake.lock
├── home/
│   ├── default.nix
│   ├── dconf.nix
│   ├── xdg.nix
│   ├── programs.nix
│   ├── alacritty/
│   │   ├── themes/
│   │   ├── images/
│   │   └── ...
│   └── wallpapers/
├── system/
│   ├── configuration.nix
│   ├── hardware-configuration.nix
│   ├── tailscale.auth
│   └── modules/
│       ├── boot.nix
│       ├── console.nix
│       ├── fonts.nix
│       ├── hardware.nix
│       ├── internationalisation.nix
│       ├── networking.nix
│       ├── nixsettings.nix
│       ├── packages.nix
│       ├── programs.nix
│       ├── security.nix
│       ├── services.nix
│       ├── stylix.nix
│       ├── time.nix
│       ├── users.nix
│       └── virtualisation.nix
```

## Detailed Module Overview

### System Configuration

- **Boot**: GRUB bootloader configuration, ZFS support, and kernel parameters.
- **Console**: Console font and keyboard layout settings.
- **Fonts**: Extensive font package installation and configuration.
- **Hardware**: Graphics card support, Bluetooth, and PulseAudio configuration.
- **Internationalization**: Locale and language settings.
- **Networking**: Hostname, NetworkManager, firewall, and interface configurations.
- **Nix Settings**: Nix-specific configurations including experimental features.
- **Packages**: System-wide package installations.
- **Programs**: Enabled system programs like Zsh and dconf.
- **Security**: Security-related settings including PAM and rtkit.
- **Services**: System services configuration including OpenSSH, Printing, Tailscale, and GNOME-related services.
- **Stylix**: System-wide theming configuration.
- **Time**: Timezone configuration.
- **Users**: User account setup and permissions.
- **Virtualization**: Configuration for libvirtd, QEMU, and Docker.

### Home Manager Configuration

- **Default**: Main Home Manager configuration.
- **dconf**: GNOME-specific settings using dconf.
- **XDG**: XDG base directory specification compliance.
- **Programs**: User-specific program configurations including:
  - Git
  - Chromium
  - Firefox
  - Zathura
  - OBS Studio
  - Zsh (with Oh My Zsh)
  - Visual Studio Code
  - Alacritty
  - Rofi

## Installed Packages

Here's a list of some key packages installed in this configuration:

- bat (Modern cat clone with syntax highlighting)
- eza (Modern replacement for ls)
- fzf (Command-line fuzzy finder)
- git (Version control system)
- go (Go programming language)
- rust (Rust programming language and tools)
- vscode (Visual Studio Code editor)
- firefox (Web browser)
- chromium (Web browser)
- alacritty (GPU-accelerated terminal emulator)
- zsh (Z shell)
- oh-my-zsh (Framework for managing Zsh configuration)
- obs-studio (Streaming and recording software)
- docker (Containerization platform)
- kubectl (Kubernetes command-line tool)
- minikube (Local Kubernetes cluster)
- tailscale (VPN service)
- zfs (ZFS filesystem tools)
- gnome-tweaks (GNOME customization tool)
- libreoffice (Office suite)
- gimp (Image editor)
- inkscape (Vector graphics editor)
- vlc (Media player)
- ffmpeg (Multimedia framework)
- pandoc (Universal document converter)

For a complete list of installed packages, please refer to the `packages.nix` file in the repository.

## Installation

1. Clone this repository:

   ```
   git clone https://github.com/yourusername/nix-configs.git
   cd nix-configs
   ```

2. Ensure you have a NixOS system with flakes enabled.

3. Apply the configuration:

   ```
   sudo nixos-rebuild switch --flake .#megaman
   ```

## Usage

- To update and apply changes:

  ```
  sudo nixos-rebuild switch --flake ~/repos/nix-configs/
  ```

- To upgrade the system:

  ```
  sudo nixos-rebuild switch --flake ~/repos/nix-configs/ --upgrade
  ```

## Configuration

The main configuration is split between system-wide settings (`/system`) and user-specific settings (`/home`). Key files include:

- `flake.nix`: The entry point for the Nix flake, defining inputs and outputs.
- `/system/configuration.nix`: Main system configuration, importing all system modules.
- `/home/default.nix`: Home Manager configuration, setting up user environment.

Customize these files and the modules in their respective directories to adjust the setup to your needs.

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a new branch for your feature
3. Commit your changes
4. Push to your fork
5. Submit a pull request

## Testing

Before submitting changes, please test your configuration:

1. Build the configuration without applying:

   ```
   nixos-rebuild build --flake .#megaman
   ```

2. If successful, switch to the new configuration and ensure everything works as expected.

## License

This project is licensed under the [MIT License](LICENSE).

## Acknowledgements

- [NixOS](https://nixos.org/)
- [Home Manager](https://github.com/nix-community/home-manager)
- [Stylix](https://github.com/danth/stylix)
- All other open-source projects used in this configuration

This configuration is tailored for a specific setup named "megaman". Users should review and adjust settings, especially hardware-specific ones, before applying to their own systems.
