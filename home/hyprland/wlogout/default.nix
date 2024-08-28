{
  programs.wofi = {
    enable = true;
    settings = {
      width = 600;
      height = 400;
      location = "center";
      show = "drun";
      prompt = "Search...";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 40;
    };
    style = ''
      window {
        margin: 0px;
        border: 2px solid #33ccff;
        background-color: rgba(0, 0, 0, 0.8);
        border-radius: 10px;
      }

      #input {
        margin: 5px;
        border: none;
        color: #ffffff;
        background-color: rgba(55, 55, 55, 0.9);
      }

      #inner-box {
        margin: 5px;
        border: none;
        background-color: transparent;
      }

      #outer-box {
        margin: 5px;
        border: none;
        background-color: transparent;
      }

      #scroll {
        margin: 0px;
        border: none;
      }

      #text {
        margin: 5px;
        border: none;
        color: #ffffff;
      }

      #entry:selected {
        background-color: rgba(51, 204, 255, 0.7);
        border-radius: 5px;
      }
    '';
  };
}
