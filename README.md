# NixOS Configuration with Home Manager

A comprehensive NixOS and Home Manager configuration using Nix flakes for a personalized GNOME-based desktop environment. This setup is designed for a system named "megaman" and includes extensive customizations for development, virtualization, and daily use.

To be added: config files for sonic (macOS), bomberman (homelab) and donkey-kong (cloud server).

## Features

- Modular NixOS system configuration
- Home Manager integration for user environment management
- GNOME desktop environment with custom extensions and settings
- Development tools setup (VSCode, Git, Go, Rust, Python, Node.js)
- Virtualization support (QEMU, libvirt, Docker)
- Tailscale VPN integration
- ZFS filesystem support
- Custom font configuration with a wide variety of fonts
- System-wide theming with Stylix
- Advanced networking setup for multiple interfaces
- AMD GPU optimization
- Extensive package selection for productivity and development

## Source Tree

```
nix-configs
├── flake.nix
├── home
│   ├── default.nix
│   ├── xdg.nix
│   ├── programs.nix
│   ├── aliases.nix
│   ├── direnv.nix
│   ├── assets
│   │   ├── userChrome.css
│   │   ├── userContent.css
│   │   └── wallpapers
│   │       └── (files)
│   ├── programs
│   │   ├── git.nix
│   │   ├── firefox.nix
│   │   ├── vscode.nix
│   │   ├── alacritty.nix
│   │   ├── zellij.nix
│   │   └── kitty.nix
│   └── gnome
│       ├── default.nix
│       └── dconf.nix
├── system
│   ├── configuration.nix
│   ├── modules
│   │   ├── default.nix
│   │   ├── fonts.nix
│   │   ├── internationalisation.nix
│   │   ├── networking.nix
│   │   ├── nixsettings.nix
│   │   ├── programs.nix
│   │   ├── time.nix
│   │   ├── users.nix
│   │   ├── virtualisation.nix
│   │   ├── services.nix
│   │   ├── hardware.nix
│   │   ├── security.nix
│   │   ├── boot.nix
│   │   ├── packages.nix
│   │   ├── console.nix
│   │   ├── stylix.nix
│   │   ├── zfs.nix
│   │   ├── gnome.nix
│   │   └── secrets
│   └── hardware-configuration.nix
└── flake.lock
```

## Installation

1. Clone this repository:

   ```bash
   git clone https://github.com/fredcamaral/nix-config.git ~/repos/nix-configs # opinionated repo location for aliases
   cd ~/repos/nix-configs
   ```

2. Ensure you have a NixOS system with flakes enabled.

3. Review and adjust the configuration files, especially:
   - `flake.nix`
   - `system/hardware-configuration.nix`
   - `home/default.nix`

4. Apply the configuration:

   ```bash
   sudo nixos-rebuild switch --flake .#megaman
   ```

## Usage

- Update and apply changes:

  ```bash
  sudo nixos-rebuild switch --flake ~/repos/nix-configs/
  ```

- Upgrade the system:

  ```bash
  sudo nixos-rebuild switch --flake ~/repos/nix-configs/ --upgrade
  ```

- Use the provided aliases (in `home/aliases.nix`) for common tasks:
  - `cdnc`: Navigate to the NixOS config directory
  - `rebuild`: Shortcut for rebuilding NixOS
  - `upgrade`: Update flake inputs and upgrade NixOS

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

   ```bash
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

---

**Note:** This configuration is tailored for a specific setup named "megaman". Users should review and adjust settings, especially hardware-specific ones, before applying to their own systems.
