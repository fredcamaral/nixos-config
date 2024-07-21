# system/modules/packages.nix
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # to-organize
    dopamine # Music player that tries to make organizing and listening to music easy and pretty
    taskwarrior3 # Task management tool
    taskwarrior-tui # Taskwarrior terminal user interface

    # Archiving and Compression
    unrar # Extraction utility for RAR archives
    unzip # Extraction utility for ZIP archives
    zip # Compressor/archiver for creating and modifying ZIP files
    pigz # Parallel implementation of gzip for faster compression

    # Backup and Recovery
    restic # Fast, secure, and efficient backup program

    # Communication and Collaboration
    teams-for-linux # Microsoft Teams client for Linux
    telegram-desktop # Fast and secure messaging app
    zoom-us # Video conferencing and online meeting platform
    google-chrome # Web browser developed by Google

    # Development and Programming
    cargo # Rust package manager and build tool
    clang # C language family frontend for LLVM compiler
    devenv # Development environment management tool for Nix
    gcc # GNU Compiler Collection for various programming languages
    git # Distributed version control system
    gnumake # Build automation tool
    go # The Go programming language and tools
    lld_18 # LLVM Linker for faster linking
    nodejs # JavaScript runtime built on Chrome's V8 engine
    pipx # Tool to install and run Python applications in isolated environments
    python3 # High-level, interpreted programming language
    rustfmt # Code formatter for Rust
    rustup # Rust toolchain installer and version management tool
    yarn # Fast, reliable, and secure dependency management for JavaScript
    tree-sitter # Incremental parsing library for syntax highlighting and code analysis
    diffsitter # Syntax-aware diff tool using tree-sitter
    electron # Framework for building cross-platform desktop applications with web technologies

    # Development Utilities
    direnv # Environment switcher for the shell
    grex # Command-line tool for generating regular expressions from user-provided test cases
    hyperfine # Command-line benchmarking tool
    jq # Lightweight command-line JSON processor
    nix-direnv # Fast loader and flake-aware nix-shell replacement for direnv
    tokei # Program to quickly count and analyze code
    vscode # Powerful source code editor

    # File Sharing
    qbittorrent # Feature-rich BitTorrent client

    # File Systems
    zfs # OpenZFS implementation for Linux
    zfsnap # Automatic snapshot manager for ZFS
    zfstools # Additional utilities for OpenZFS administration

    # Graphics and Design
    drawio # Diagram drawing application
    gimp # GNU Image Manipulation Program for image editing
    graphviz # Graph visualization software
    inkscape # Vector graphics editor

    # Hardware Management
    logitech-udev-rules # Udev rules for Logitech devices
    solaar # Device manager for Logitech peripherals

    # Media Creation and Editing
    asciinema # Terminal session recorder
    obs-studio # Open Broadcaster Software for video recording and live streaming
    peek # Simple animated GIF screen recorder

    # Multimedia Tools
    feh # Lightweight and fast image viewer
    ffmpeg # Complete solution to record, convert and stream audio and video
    imagemagick # Software suite for creating, editing, and manipulating images
    vlc # Cross-platform multimedia player

    # Networking Tools
    curl # Command-line tool for transferring data using various protocols
    ethtool # Utility for controlling network drivers and hardware
    nmap # Network exploration tool and security scanner
    rclone # Command-line program to sync files and directories to and from cloud storage
    tailscale # Mesh VPN that makes it easy to connect your devices
    tcpdump # Powerful command-line packet analyzer
    wget # Utility for non-interactive download of files from the Web

    # Nix-specific Tools
    alejandra # Opinionated Nix code formatter
    dconf2nix # Convert dconf files to Nix configuration
    nix-index # Quickly locate Nix packages with specific files
    nix-tree # Interactively browse dependency graphs of Nix derivations
    nixpkgs-fmt # Nix code formatter for nixpkgs

    # Presentation Tools
    graph-easy # Convert or render graphs in various formats (ASCII, HTML, SVG, graphviz)
    slides # Terminal-based presentation tool
    presenterm # Another terminal-based presentation tool

    # Productivity and Office
    calibre # E-book management application
    libreoffice # Comprehensive, professional-quality productivity suite
    obsidian # Knowledge base that works on top of local Markdown files
    okular # Universal document viewer

    # Security and Privacy
    openssl # Toolkit for the Transport Layer Security (TLS) and Secure Sockets Layer (SSL) protocols
    tor-browser-bundle-bin # Web browser focused on anonymity and security

    # System Administration
    bash # GNU Bourne-Again Shell
    lsof # Utility to list open files
    stress # Tool to impose load on and stress test systems
    tmux # Terminal multiplexer for detaching processes from terminals

    # System and File Management
    bat # Cat clone with syntax highlighting and Git integration
    du-dust # More intuitive version of du written in Rust
    duf # Disk Usage/Free Utility with colorful output
    eza # Modern replacement for 'ls' command
    fd # Simple, fast alternative to 'find'
    file # Utility to determine file types
    fzf # Command-line fuzzy finder
    gparted # Graphical disk partitioning tool
    mc # Midnight Commander, a visual file manager
    ripgrep # Fast search tool similar to grep and The Silver Searcher
    tree # Display directories as trees

    # System Monitoring and Diagnostics
    bottom # Cross-platform graphical process/system monitor
    htop # Interactive process viewer
    btop # Resource monitor showing usage stats for processor, memory, disks, network and processes
    iotop # I/O monitoring tool
    lm_sensors # Tools for reading hardware sensors
    lshw # Hardware lister to provide detailed information on the hardware configuration
    neofetch # Fast, highly customizable system info script
    pciutils # Set of programs for inspecting and manipulating configuration of PCI devices
    powertop # Power consumption and power management diagnosis tool
    smartmontools # Tools for monitoring and controlling S.M.A.R.T. enabled hard drives
    usbutils # USB utilities (such as lsusb)
    lact # AMD GPU overclocking and monitoring tool

    # System Utilities
    remmina # Remote desktop client for POSIX-based computer systems

    # Text Processing and Documentation
    pandoc # Universal markup converter
    tldr # Simplified and community-driven man pages

    # Utilities
    bandwhich # Terminal bandwidth utilization tool
    code2prompt # Generate command descriptions for AI assistants
    eva # Simple calculator REPL
    fio # Flexible I/O Tester for benchmarking and stress-testing
    ocrmypdf # Adds OCR text layer to scanned PDF files
    qpdf # Command-line tool for structural, content-preserving transformations of PDF files
    sd # Intuitive find & replace CLI tool
    zola # Fast static site generator in a single binary
    busybox # Tiny utilities for small and embedded systems
    ibus-with-plugins # Intelligent Input Bus for Linux and Unix-like operating systems
    ibus-engines.typing-booster # Predictive text input method for IBus
    parallel-full # Shell tool for executing jobs in parallel
    moreutils # Growing collection of the unix tools that nobody thought to write long ago
    wl-clipboard # Command-line copy/paste utilities for Wayland

    # Virtualization and Containerization
    docker_27 # Platform for developing, shipping, and running applications in containers
    kubectl # Command-line tool for controlling Kubernetes clusters
    kubernetes-helm # Package manager for Kubernetes
    minikube # Tool that makes it easy to run Kubernetes locally
  ];
}
