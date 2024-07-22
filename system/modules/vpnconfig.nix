{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.networking.vpnConfig;
in {
  options.networking.vpnConfig = {
    enable = mkEnableOption "VPN configuration";

    defaultGatewayAddress = mkOption {
      type = types.str;
      default = "21.26.7.1";
      description = "Default gateway IP address";
    };

    nameservers = mkOption {
      type = types.listOf types.str;
      default = ["8.8.8.8" "1.1.1.1"];
      description = "List of DNS servers";
    };

    networkPrefix = mkOption {
      type = types.str;
      default = "21.26.7";
      description = "Network prefix for IP addresses";
    };

    freeFlowInterface = mkOption {
      type = types.str;
      default = "enp11s0";
      description = "Interface for non-VPN traffic";
    };

    vpnedInterface = mkOption {
      type = types.str;
      default = "enp10s0";
      description = "Interface for VPN traffic";
    };

    vpnedPorts = mkOption {
      type = types.str;
      default = "80,443,8080";
      description = "Ports to be routed through VPN";
    };

    hostName = mkOption {
      type = types.str;
      default = "megaman";
      description = "Hostname of the system";
    };
  };

  config = mkMerge [
    # Common configuration (applies regardless of enable status)
    {
      networking = {
        hostName = cfg.hostName;
        nameservers = cfg.nameservers;
        defaultGateway = cfg.defaultGatewayAddress;

        interfaces = {
          ${cfg.freeFlowInterface} = {
            ipv4.addresses = [
              {
                address = "${cfg.networkPrefix}.2";
                prefixLength = 24;
              }
            ];
          };
          ${cfg.vpnedInterface} = {
            ipv4.addresses = [
              {
                address = "${cfg.networkPrefix}.3";
                prefixLength = 24;
              }
            ];
          };
        };

        firewall = {
          enable = true;
          trustedInterfaces = [cfg.freeFlowInterface cfg.vpnedInterface];
        };
      };

      programs.nm-applet.enable = true;

      boot.kernel.sysctl = {
        "net.ipv4.ip_forward" = 1;
      };
    }

    # VPN-specific configuration (only applies when enabled)
    (mkIf cfg.enable {
      networking = {
        networkmanager.enable = true;
        enableIPv6 = false;

        networkmanager.unmanaged = [cfg.vpnedInterface cfg.freeFlowInterface];

        networkmanager.settings = {
          main = {
            no-auto-default = "*";
          };
        };

        firewall = {
          extraCommands = ''
            iptables -t mangle -F
            iptables -t nat -F
            iptables -t mangle -A PREROUTING -p tcp -m multiport --dports ${cfg.vpnedPorts} -j MARK --set-mark 1
            iptables -t mangle -A OUTPUT -p tcp -m multiport --dports ${cfg.vpnedPorts} -j MARK --set-mark 1
            iptables -t nat -A POSTROUTING -m mark --mark 1 -o ${cfg.vpnedInterface} -j MASQUERADE
          '';
        };

        iproute2 = {
          enable = true;
          rttablesExtraConfig = ''
            200 marked
          '';
        };
      };

      systemd.services.custom-routes = {
        description = "Set up custom routes and rules";
        after = ["network-online.target"];
        wants = ["network-online.target"];
        wantedBy = ["multi-user.target"];
        path = [pkgs.iproute2];
        script = ''
          run_cmd() {
            "$@" || echo "Command failed: $*"
          }

          run_cmd ip route flush table marked
          run_cmd ip rule del fwmark 1 table marked
          run_cmd ip rule add fwmark 1 table marked priority 90
          run_cmd ip route add default via ${cfg.defaultGatewayAddress} dev ${cfg.vpnedInterface} table marked
          run_cmd ip route del default
          run_cmd ip route add default via ${cfg.defaultGatewayAddress} dev ${cfg.freeFlowInterface}

          echo "Current ip rules:"
          ip rule show
          echo "Current main routing table:"
          ip route show table main
          echo "Current marked routing table:"
          ip route show table marked
        '';
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };
      };
    })
  ];
}
