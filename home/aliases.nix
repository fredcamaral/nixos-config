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
    cdnc = "cd ~/repos/nix-configs";

    # Shortcut for rebuilding NixOS
    rebuild = "sudo nixos-rebuild switch --flake ~/repos/nix-configs/";

    # Shortcut for upgrading NixOS
    upgrade = ''
      cd ~/repos/nix-configs
      sudo nix flake update
      sudo nixos-rebuild boot --flake ~/repos/nix-configs/ --upgrade
      echo "Upgrade complete! Reboot your computer..."
    '';

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
    gacp = "git add . && git commit -m 'new update' && git push";
  };
}
