# system/modules/packages.nix
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    cachix
    gnumake
    killall
    niv
    rxvt_unicode
    xclip
    firefox
    kitty
    vscode
    zellij
    git
    atuin
    bat
    bottom
    btop
    direnv
    eza
    fzf
    htop
    jq
    lazygit
    micro
    neovim
    nix-index
    ripgrep
    tmux
    yazi
    zathura
    zoxide
    zsh

    # For hypervisors that support auto-resizing, this script forces it.
    # I've noticed not everyone listens to the udev events so this is a hack.
    (writeShellScriptBin "xrandr-auto" ''
      xrandr --output Virtual-1 --auto
    '')
  ];
}
