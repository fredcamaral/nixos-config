let
  configDir = ./dotfiles;
in {
  home.file = {
    # ".config/btop".source = "${configDir}/btop";
  };
}
