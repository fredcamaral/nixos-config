# home/default.nix
{pkgs, ...}: let
  user = "fredamaral";
in {
  # Set up the home directory and environment variables
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    # Set session variables
    sessionVariables = {
      BROWSER = "firefox";
      EDITOR = "micro";
      TERMINAL = "kitty";
    };
  };

  # Import additional configuration files
  imports = [
    ./xdg.nix
    ./programs.nix
    ./aliases.nix
    ./direnv.nix
  ];

  # Enable numlock on session start
  xsession.numlock.enable = true;

  # Enable Home Manager
  programs.home-manager.enable = true;

  # Set the state version for Home Manager
  home.stateVersion = "24.05";
}
