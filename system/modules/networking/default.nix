{...}: {
  # Import the module
  imports = ./routing.nix;

  # Define the config for the module networking
  networking.vpnConfig = {
    enable = true;
    hostName = "megaman";
    defaultGatewayAddress = "21.26.7.1";
    nameservers = ["8.8.8.8" "1.1.1.1"];
    networkPrefix = "21.26.7";
    freeFlowInterface = "enp11s0";
    vpnedInterface = "enp10s0";
    vpnedPorts = "80,443,8080";
  };
}
