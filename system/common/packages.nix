# system/modules/packages.nix
{
  pkgs,
  pkgs-unstable,
  pkgs-stable,
  ...
}: {
  environment.systemPackages = [
    # to-organize
    pkgs.age # Tool for encrypting files
    pkgs.vlc # Open-source media player
    pkgs.grim # Screenshot utility
    pkgs.slurp # Screenshot utility
    pkgs.wl-clipboard # Clipboard manager for Wayland
    pkgs.go # Go programming language
    pkgs.go-tools # Go programming language
    pkgs.home-manager # Home Manager
    pkgs-unstable.gnome-calculator # GNOME calculator
    pkgs.kdePackages.kate # KDE text editor
    pkgs.cmake # Cross-platform make

    # Archiving and Compression
    pkgs.pigz # Parallel implementation of gzip for faster compression
    pkgs.unrar # Extraction utility for RAR archives
    pkgs.unzip # Extraction utility for ZIP archives
    pkgs.zip # Compressor/archiver for creating and modifying ZIP files

    # Development and Programming
    pkgs.devenv # Development environment management tool for Nix
    pkgs.electron # Framework for building cross-platform desktop applications with web technologies
    pkgs.gcc # GNU Compiler Collection for various programming languages
    pkgs.gnumake # Build automation tool

    # Development Utilities
    pkgs.grex # Command-line tool for generating regular expressions from user-provided test cases
    pkgs.hyperfine # Command-line benchmarking tool
    pkgs.nix-direnv # Fast loader and flake-aware nix-shell replacement for direnv

    # File Sharing
    pkgs.qbittorrent # Feature-rich BitTorrent client

    # File Systems
    pkgs.zfs # OpenZFS implementation for Linux
    pkgs.zfsnap # Automatic snapshot manager for ZFS
    pkgs.zfstools # Additional utilities for OpenZFS administration

    # Hardware Management
    pkgs.logitech-udev-rules # Udev rules for Logitech devices
    pkgs.solaar # Device manager for Logitech peripherals

    # Multimedia Tools
    pkgs.feh # Lightweight and fast image viewer
    pkgs.ffmpeg # Complete solution to record, convert and stream audio and video

    # Networking Tools
    pkgs.curl # Command-line tool for transferring data using various protocols
    pkgs.ethtool # Utility for controlling network drivers and hardware
    pkgs.nmap # Network exploration tool and security scanner
    pkgs.tcpdump # Powerful command-line packet analyzer
    pkgs.wget # Utility for non-interactive download of files from the Web

    # Nix-specific Tools
    pkgs.alejandra # Opinionated Nix code formatter
    pkgs.nix-tree # Interactively browse dependency graphs of Nix derivations
    pkgs.nixpkgs-fmt # Nix code formatter for nixpkgs

    # Productivity and Office
    pkgs.calibre # E-book management application
    pkgs.libreoffice # Comprehensive, professional-quality productivity suite
    pkgs.obsidian # Knowledge base that works on top of local Markdown files

    # System Administration
    pkgs.bash # GNU Bourne-Again Shell
    pkgs.lsof # Utility to list open files
    pkgs.stress # Tool to impose load on and stress test systems

    # System and File Management
    pkgs.du-dust # More intuitive version of du written in Rust
    pkgs.duf # Disk Usage/Free Utility with colorful output
    pkgs.fd # Simple, fast alternative to 'find'
    pkgs.file # Utility to determine file types
    pkgs.gparted # Graphical disk partitioning tool

    # System Monitoring and Diagnostics
    pkgs.iotop # I/O monitoring tool
    pkgs.lm_sensors # Tools for reading hardware sensors
    pkgs.lshw # Hardware lister to provide detailed information on the hardware configuration
    pkgs.neofetch # Fast, highly customizable system info script
    pkgs.pciutils # Set of programs for inspecting and manipulating configuration of PCI devices
    pkgs.smartmontools # Tools for monitoring and controlling S.M.A.R.T. enabled hard drives
    pkgs.usbutils # USB utilities (such as lsusb)

    # System Utilities
    pkgs.clipman # Clipboard manager for Xfce
    pkgs.gvfs # Virtual filesystem implementation for GIO
    pkgs.kio-fuse # FUSE support for KIO
    pkgs.pulseaudioFull # Sound server for POSIX and Win32 systems
    pkgs.vimix-icon-theme # Icon theme for Linux
    pkgs.wirelesstools # Tools for setting up wireless networking

    # Text Processing and Documentation
    pkgs.tldr # Simplified and community-driven man pages

    # Utilities
    pkgs-unstable.bandwhich # Terminal bandwidth utilization tool
    pkgs.busybox # Tiny utilities for small and embedded systems
    pkgs-unstable.code2prompt # Generate command descriptions for AI assistants
    pkgs.eva # Simple calculator REPL
    pkgs.fio # Flexible I/O Tester for benchmarking and stress-testing
    pkgs.lazydocker # The lazier way to manage everything docker
    pkgs.moreutils # Growing collection of the unix tools that nobody thought to write long ago
    pkgs.parallel-full # Shell tool for executing jobs in parallel
    pkgs.sd # Intuitive find & replace CLI tool

    # Virtualization and Containerization
    pkgs.docker_27 # Platform for developing, shipping, and running applications in containers
    pkgs.kubectl # Command-line tool for controlling Kubernetes clusters
    pkgs.kubernetes-helm # Package manager for Kubernetes
    pkgs.minikube # Tool that makes it easy to run Kubernetes locally
  ];
}
