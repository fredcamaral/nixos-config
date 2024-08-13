# home/aliases.nix
{...}: {
  home.shellAliases = {
    # Use 'bat' instead of 'cat' for syntax highlighting
    cat = "bat";

    # Use 'eza' instead of 'ls' with icons always enabled
    ls = "eza --icons=always -o --git -s type";

    # Full system cleanup
    full-clean = ''
      nix-collect-garbage --delete-old
      home-manager expire-generations "-30 days"
      sudo nix-collect-garbage -d
      sudo /run/current-system/bin/switch-to-configuration boot
    '';

    # Quick navigation to NixOS config directory
    cdnc = "cd ~/repos/nixos-config";

    # NixOS rebuild
    rebuild-nixos = "sudo nixos-rebuild switch --flake ~/repos/nixos-config/";

    # Home Manager rebuild
    rebuild-home = "home-manager switch --flake ~/repos/nixos-config/";

    # Rebuild both NixOS and Home Manager
    rebuild-all = ''
      rebuild-nixos
      rebuild-home
    '';

    # NixOS rebuild for boot
    rebuild-for-boot = "sudo nixos-rebuild boot --flake ~/repos/nixos-config/";

    # Upgrade NixOS
    upgrade-nixos = ''
      cd ~/repos/nixos-config
      sudo nix flake update
      sudo nixos-rebuild boot --flake ~/repos/nixos-config/ --upgrade
      echo "NixOS upgrade complete! Reboot your computer..."
    '';

    # Upgrade Home Manager
    upgrade-home = ''
      cd ~/repos/nixos-config
      nix flake update
      home-manager switch --flake ~/repos/nixos-config/
      echo "Home Manager upgrade complete!"
    '';

    # Upgrade both NixOS and Home Manager
    upgrade-all = ''
      cd ~/repos/nixos-config
      sudo nix flake update
      sudo nixos-rebuild boot --flake ~/repos/nixos-config/ --upgrade
      echo "NixOS upgrade complete! Reboot your computer..."
      home-manager switch --flake ~/repos/nixos-config/
      echo "Home Manager upgrade complete!"
    '';

    # Shortcut for importing all ZFS pools
    import-pools = "sudo zpool import -a";

    # Use 'nvim' instead of 'vim' or 'vi'
    vim = "nvim";
    vi = "nvim";

    # Common ls aliases
    ll = "ls -l";
    la = "ls -la";

    # Tmux aliases
    tm = "tmux";
    tms = "tmux new -s";
    tml = "tmux list-sessions";
    tma = "tmux attach -t";
    tmk = "tmux kill-session -t";

    # Git aliases
    gacp = "git add . && git commit -m 'new update' && git push --all";
    gac = "git add . && git commit -m 'new update'";
    ga = "git add .";
  };
}
