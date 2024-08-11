{pkgs, ...}: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      effect-blur = "7x5";
      fade-in = 0.2;

      clock = true;
      indicator = true;
      indicator-radius = 100;
      indicator-thickness = 7;

      effect-vignette = "0.5:0.5";

      grace = 2;
      grace-no-mouse = true;
      grace-no-touch = true;

      datestr = "%a, %B %e";
      timestr = "%I:%M %p";

      screenshots = true;
    };
  };
}
