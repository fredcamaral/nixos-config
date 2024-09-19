{
  config,
  lib,
  ...
}: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        browser = "${config.programs.firefox.package}/bin/firefox";
        dmenu = "${config.programs.rofi.package}/bin/rofi -dmenu -p dunst";
        follow = "keyboard";
        format = ''<b>%s</b>\n%b'';
        frame_color = "#53BDFA";
        frame_width = 1;
        geometry = "500x50-15+15";
        hide_duplicates_count = "yes";
        horizontal_padding = 6;
        icon_position = "left";
        idle_threshold = 0;
        ignore_newline = "no";
        line_height = 3;
        markup = "yes";
        max_icon_size = 80;
        padding = 6;
        plain_text = "no";
        separator_height = 2;
        shrink = "no";
        stack_duplicates = "yes";
        word_wrap = "yes";
      };
    };
  };

  systemd.user.services.dunst.Install.WantedBy = lib.mkForce ["i3-session.target"];
}
