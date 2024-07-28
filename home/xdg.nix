# home/xdg.nix
{config, ...}: {
  xdg = {
    # Enable XDG Base Directory specification
    enable = true;

    # Force creation of the mimeapps.list file
    configFile."mimeapps.list".force = true;

    # Configure XDG user directories
    userDirs = {
      enable = true;

      # Set custom paths for XDG directories
      desktop = "${config.home.homeDirectory}/desktop";
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      music = "${config.home.homeDirectory}/music";
      pictures = "${config.home.homeDirectory}/pictures";
      publicShare = "${config.home.homeDirectory}/public";
      templates = "${config.home.homeDirectory}/templates";
      videos = "${config.home.homeDirectory}/videos";
    };

    # Configure default applications for MIME types
    mimeApps = {
      enable = true;

      defaultApplications = {
        # PDF files
        "application/pdf" = ["okular.desktop"]; # Use Okular for PDFs

        # Web content
        "text/html" = ["firefox.desktop"];
        "text/xml" = ["firefox.desktop"];
        "x-scheme-handler/http" = ["firefox.desktop"];
        "x-scheme-handler/https" = ["firefox.desktop"];

        # Images
        "image/gif" = ["feh.desktop"];
        "image/heif" = ["feh.desktop"];
        "image/jpeg" = ["feh.desktop"];
        "image/png" = ["feh.desktop"];
        "image/webp" = ["feh.desktop"];
        "application/octet-stream" = ["feh.desktop"]; # For matplotlib figures

        # Videos
        "video/mp4" = ["vlc.desktop"];
        "video/quicktime" = ["vlc.desktop"];
        "video/x-matroska" = ["vlc.desktop"];
        "video/x-ms-wmv" = ["vlc.desktop"];

        # Archives
        "application/zip" = ["xfce.thunar.desktop"];
        "application/x-rar" = ["xfce.thunar.desktop"];
        "application/x-7z-compressed" = ["xfce.thunar.desktop"];

        # Office documents
        "application/msword" = ["libreoffice-writer.desktop"];
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = ["libreoffice-writer.desktop"];
        "application/vnd.oasis.opendocument.text" = ["libreoffice-writer.desktop"];
        "application/vnd.ms-excel" = ["libreoffice-calc.desktop"];
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = ["libreoffice-calc.desktop"];
        "application/vnd.oasis.opendocument.spreadsheet" = ["libreoffice-calc.desktop"];

        # Text files
        "text/plain" = ["code.desktop"];

        # Torrents
        "application/x-bittorrent" = ["qbittorrent.desktop"];

        # E-books
        "application/epub+zip" = ["calibre-ebook-viewer.desktop"];
        "application/x-mobipocket-ebook" = ["calibre-ebook-viewer.desktop"];

        # Vector graphics
        "image/svg+xml" = ["inkscape.desktop"];

        # Markdown files
        "text/markdown" = ["obsidian.desktop"];
      };
    };
  };

  # Additional XDG configurations

  # Set default browser
  xdg.mimeApps.defaultApplications."x-scheme-handler/chrome" = ["firefox.desktop"];

  # Configure git to use VS Code as the default editor
  programs.git.extraConfig.core.editor = "code --wait";

  # Set default terminal emulator
  xdg.mimeApps.defaultApplications."x-scheme-handler/terminal" = ["kitty.desktop"];

  # Configure default applications for common tasks
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/mailto" = ["thunderbird.desktop"]; # Email
    "x-scheme-handler/magnet" = ["qbittorrent.desktop"]; # Magnet links
    "application/x-shellscript" = ["code.desktop"]; # Shell scripts
  };
}
