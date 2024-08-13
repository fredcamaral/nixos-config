{hostname, ...}: {
  # Import the modules
  imports = map (module: ./${module}.nix) [
    "console"
    "hardware"
    "services"
    "virtualisation"
    "packages"
    "xserver"
  ];

  # Enables support for running x86_64 binaries on the system.
  # This is useful for running 32-bit applications or other
  # architectures that may be needed on the system.
  boot.binfmt.emulatedSystems = ["x86_64-linux"];

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    useDHCP = false;
    interfaces.ens160.useDHCP = true;
  };
}
