# home/aliases.nix
{...}: {
  home.shellAliases = {
    # Use 'bat' instead of 'cat' for syntax highlighting
    cat = "bat";

    # Use 'eza' instead of 'ls' with icons always enabled
    ls = "eza --icons=always";

    # Alias for full system cleanup
    fullClean = ''
      nix-collect-garbage --delete-old
      sudo nix-collect-garbage -d
      sudo /run/current-system/bin/switch-to-configuration boot
    '';

    # Quick navigation to NixOS config directory
    cdnc = "cd ~/repos/nixos-config";

    # Shortcut for rebuilding NixOS
    rebuild = "sudo nixos-rebuild switch --flake ~/repos/nixos-config/";

    # Shortcut for rebuilding NixOS
    rebuildForBoot = "sudo nixos-rebuild boot --flake ~/repos/nixos-config/";

    # Shortcut for upgrading NixOS
    upgrade = ''
      cd ~/repos/nixos-config
      sudo nix flake update
      sudo nixos-rebuild boot --flake ~/repos/nixos-config/ --upgrade
      echo "Upgrade complete! Reboot your computer..."
    '';

    # Shortcut for importing all ZFS pools
    importPools = "sudo zpool import -a";

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

    # Git add, commit, and push in one command
    gacp = "git add . && git commit -m 'new update' && git push --all";
    # Git add, commit, and push in one command
    gac = "git add . && git commit -m 'new update'";
    # Git add, commit, and push in one command
    ga = "git add .";
  };
}
