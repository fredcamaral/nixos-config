# system/modules/networking.nix
{
  config,
  pkgs,
  ...
}:
# Define common variables for easy configuration
let
  defaultGatewayAddress = "21.26.7.1"; # Default gateway IP address
  nameservers = ["8.8.8.8" "1.1.1.1"]; # DNS servers
  networkPrefix = "21.26.7"; # Network prefix for IP addresses
  freeFlowInterface = "enp11s0"; # Interface for non-VPN traffic
  vpnedInterface = "enp10s0"; # Interface for VPN traffic
  vpnedPorts = "80,443,8080"; # Ports to be routed through VPN
in {
  networking = {
    hostName = "megaman"; # Set the hostname of the system
    networkmanager.enable = true; # Enable NetworkManager for network management
    enableIPv6 = false; # Disable IPv6

    # Prevent NetworkManager from managing specific interfaces
    networkmanager.unmanaged = ["enp10s0" "enp11s0"];

    # Disable NetworkManager's automatic default route modification
    networkmanager.settings = {
      main = {
        no-auto-default = "*";
      };
    };

    # Firewall configuration
    firewall = {
      enable = true; # Enable the firewall
      trustedInterfaces = [freeFlowInterface vpnedInterface]; # Trust these interfaces
      extraCommands = ''
        # Flush existing mangle and nat table rules
        iptables -t mangle -F
        iptables -t nat -F
        # Mark packets destined for specific ports in PREROUTING chain
        iptables -t mangle -A PREROUTING -p tcp -m multiport --dports ${vpnedPorts} -j MARK --set-mark 1
        # Mark packets destined for specific ports in OUTPUT chain
        iptables -t mangle -A OUTPUT -p tcp -m multiport --dports ${vpnedPorts} -j MARK --set-mark 1
        # Apply NAT for marked packets going out through ${vpnedInterface}
        iptables -t nat -A POSTROUTING -m mark --mark 1 -o ${vpnedInterface} -j MASQUERADE
      '';
    };

    inherit nameservers; # Set the nameservers

    defaultGateway = null; # Do not set a global default gateway

    # Configure network interfaces
    interfaces = {
      enp11s0 = {
        ipv4.addresses = [
          {
            address = "${networkPrefix}.2";
            prefixLength = 24;
          }
        ];
      };
      enp10s0 = {
        ipv4.addresses = [
          {
            address = "${networkPrefix}.3";
            prefixLength = 24;
          }
        ];
      };
    };

    # Configure policy-based routing
    iproute2 = {
      enable = true; # Enable iproute2 configuration
      rttablesExtraConfig = ''
        200 marked
      ''; # Add a custom routing table named "marked" with ID 200
    };
  };

  programs.nm-applet.enable = true; # Enable NetworkManager applet

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1; # Enable IP forwarding
  };

  # Custom routing service
  systemd.services.custom-routes = {
    description = "Set up custom routes and rules";
    after = ["network-online.target"]; # Run after network is online
    wants = ["network-online.target"];
    wantedBy = ["multi-user.target"]; # Start on normal boot
    path = [pkgs.iproute2]; # Ensure iproute2 is available
    script = ''
      # Function to run command and continue on error
      run_cmd() {
        "$@" || echo "Command failed: $*"
      }

      # Ensure the marked table exists and is empty
      run_cmd ip route flush table marked

      # Remove existing rules for marked packets
      run_cmd ip rule del fwmark 1 table marked

      # Add rule for marked packets with higher priority
      run_cmd ip rule add fwmark 1 table marked priority 90

      # Add route for marked packets
      run_cmd ip route add default via ${defaultGatewayAddress} dev ${vpnedInterface} table marked

      # Ensure main table has the correct default route
      run_cmd ip route del default
      run_cmd ip route add default via ${defaultGatewayAddress} dev ${freeFlowInterface}

      # Display the current routing setup
      echo "Current ip rules:"
      ip rule show
      echo "Current main routing table:"
      ip route show table main
      echo "Current marked routing table:"
      ip route show table marked
    '';
    serviceConfig = {
      Type = "oneshot"; # Run once and exit
      RemainAfterExit = true; # Consider the service as active after it exits
    };
  };
}
