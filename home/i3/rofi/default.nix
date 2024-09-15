{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    extraConfig = {
      modi = "drun";
      width = 500;
      lines = 15;
      columns = 1;
      location = 0;
      padding = 5;
      yoffset = 0;
      xoffset = 0;
      fixed-num-lines = true;
      show-icons = true;
      terminal = "kitty";
      drun-display-format = "{name}";
      display-drun = "tell me what you want, my master fred...";
    };
  };
}
