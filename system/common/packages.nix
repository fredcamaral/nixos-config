# system/modules/packages.nix
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # to-organize
    age # Tool for encrypting files
    vlc # Open-source media player
    grim # Screenshot utility
    slurp # Screenshot utility
    wl-clipboard # Clipboard manager for Wayland
    go # Go programming language
    go-tools # Go programming language

    # Archiving and Compression
    pigz # Parallel implementation of gzip for faster compression
    unrar # Extraction utility for RAR archives
    unzip # Extraction utility for ZIP archives
    zip # Compressor/archiver for creating and modifying ZIP files

    # Development and Programming
    devenv # Development environment management tool for Nix
    electron # Framework for building cross-platform desktop applications with web technologies
    gcc # GNU Compiler Collection for various programming languages
    gnumake # Build automation tool

    # Development Utilities
    grex # Command-line tool for generating regular expressions from user-provided test cases
    hyperfine # Command-line benchmarking tool
    nix-direnv # Fast loader and flake-aware nix-shell replacement for direnv

    # File Sharing
    qbittorrent # Feature-rich BitTorrent client

    # File Systems
    zfs # OpenZFS implementation for Linux
    zfsnap # Automatic snapshot manager for ZFS
    zfstools # Additional utilities for OpenZFS administration

    # Graphics and Design
    drawio # Diagram drawing application

    # Hardware Management
    logitech-udev-rules # Udev rules for Logitech devices
    solaar # Device manager for Logitech peripherals

    # Multimedia Tools
    feh # Lightweight and fast image viewer
    ffmpeg # Complete solution to record, convert and stream audio and video

    # Networking Tools
    curl # Command-line tool for transferring data using various protocols
    ethtool # Utility for controlling network drivers and hardware
    nmap # Network exploration tool and security scanner
    tcpdump # Powerful command-line packet analyzer
    wget # Utility for non-interactive download of files from the Web

    # Nix-specific Tools
    alejandra # Opinionated Nix code formatter
    nix-tree # Interactively browse dependency graphs of Nix derivations
    nixpkgs-fmt # Nix code formatter for nixpkgs

    # Productivity and Office
    calibre # E-book management application
    libreoffice # Comprehensive, professional-quality productivity suite
    obsidian # Knowledge base that works on top of local Markdown files

    # System Administration
    bash # GNU Bourne-Again Shell
    lsof # Utility to list open files
    stress # Tool to impose load on and stress test systems

    # System and File Management
    du-dust # More intuitive version of du written in Rust
    duf # Disk Usage/Free Utility with colorful output
    fd # Simple, fast alternative to 'find'
    file # Utility to determine file types
    gparted # Graphical disk partitioning tool

    # System Monitoring and Diagnostics
    iotop # I/O monitoring tool
    lm_sensors # Tools for reading hardware sensors
    lshw # Hardware lister to provide detailed information on the hardware configuration
    neofetch # Fast, highly customizable system info script
    pciutils # Set of programs for inspecting and manipulating configuration of PCI devices
    smartmontools # Tools for monitoring and controlling S.M.A.R.T. enabled hard drives
    usbutils # USB utilities (such as lsusb)

    # System Utilities
    clipman # Clipboard manager for Xfce
    gvfs # Virtual filesystem implementation for GIO
    kio-fuse # FUSE support for KIO
    pulseaudioFull # Sound server for POSIX and Win32 systems
    vimix-icon-theme # Icon theme for Linux
    wirelesstools # Tools for setting up wireless networking
    xfce.thunar # File manager for Xfce

    # Text Processing and Documentation
    tldr # Simplified and community-driven man pages

    # Utilities
    bandwhich # Terminal bandwidth utilization tool
    busybox # Tiny utilities for small and embedded systems
    code2prompt # Generate command descriptions for AI assistants
    eva # Simple calculator REPL
    fio # Flexible I/O Tester for benchmarking and stress-testing
    lazydocker # The lazier way to manage everything docker
    moreutils # Growing collection of the unix tools that nobody thought to write long ago
    parallel-full # Shell tool for executing jobs in parallel
    sd # Intuitive find & replace CLI tool

    # Virtualization and Containerization
    docker_27 # Platform for developing, shipping, and running applications in containers
    kubectl # Command-line tool for controlling Kubernetes clusters
    kubernetes-helm # Package manager for Kubernetes
    minikube # Tool that makes it easy to run Kubernetes locally
  ];
}
