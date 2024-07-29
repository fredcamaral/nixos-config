{
  config,
  pkgs,
  lib,
  hostname,
  ...
}:
with lib; let
  cfg = config.networking.${hostname};
in {
  options.networking.${hostname} = {
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

    primaryInterface = {
      name = mkOption {
        type = types.str;
        default = "enp11s0";
        description = "Name of the primary interface";
      };
      dhcp = mkOption {
        type = types.bool;
        default = true;
        description = "Enable DHCP for primary interface";
      };
    };

    secondaryInterface = {
      name = mkOption {
        type = types.str;
        default = "enp10s0";
        description = "Name of the secondary interface";
      };
      dhcp = mkOption {
        type = types.bool;
        default = true;
        description = "Enable DHCP for secondary interface";
      };
    };

    vpnedPorts = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable VPN port routing";
      };
      list = mkOption {
        type = types.str;
        default = "80,443,8080";
        description = "Ports to be routed through VPN";
      };
    };
  };

  config = mkMerge [
    # Common configuration (applies regardless of enable status)
    {
      networking = {
        nameservers = cfg.nameservers;
        defaultGateway = cfg.defaultGatewayAddress;

        interfaces = {
          ${cfg.primaryInterface.name} = mkMerge [
            (mkIf (!cfg.primaryInterface.dhcp) {
              ipv4.addresses = [
                {
                  address = "${cfg.primaryInterface.ipv4}";
                  prefixLength = 24;
                }
              ];
            })
            (mkIf cfg.primaryInterface.dhcp {
              useDHCP = true;
            })
          ];
          ${cfg.secondaryInterface.name} = mkMerge [
            (mkIf (!cfg.secondaryInterface.dhcp) {
              ipv4.addresses = [
                {
                  address = "${cfg.secondaryInterface.ipv4}";
                  prefixLength = 24;
                }
              ];
            })
            (mkIf cfg.secondaryInterface.dhcp {
              useDHCP = true;
            })
          ];
        };

        firewall = {
          enable = true;
          trustedInterfaces = [cfg.primaryInterface.name cfg.secondaryInterface.name];
          extraCommands = ''
            iptables -t mangle -F
            iptables -t nat -F
          '';
        };
      };

      programs.nm-applet.enable = true;

      boot.kernel.sysctl = {
        "net.ipv4.ip_forward" = 1;
      };
    }

    # VPN-specific configuration (only applies when enabled)
    (mkIf cfg.vpn.enable {
      networking = {
        networkmanager.enable = true;
        enableIPv6 = false;

        networkmanager.unmanaged = [cfg.primaryInterface.name cfg.secondaryInterface.name];

        networkmanager.settings = {
          main = {
            no-auto-default = "*";
          };
        };

        firewall = {
          extraCommands = ''
            iptables -t mangle -A PREROUTING -p tcp -m multiport --dports ${cfg.vpn.destinationPorts} -j MARK --set-mark 1
            iptables -t mangle -A OUTPUT -p tcp -m multiport --dports ${cfg.vpn.destinationPorts} -j MARK --set-mark 1
            iptables -t nat -A POSTROUTING -m mark --mark 1 -o ${cfg.secondaryInterface.name} -j MASQUERADE
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
          run_cmd ip route add default via ${cfg.defaultGatewayAddress} dev ${cfg.secondaryInterface.name} table marked
          run_cmd ip route del default
          run_cmd ip route add default via ${cfg.defaultGatewayAddress} dev ${cfg.primaryInterface.name}

          echo "-------------";
          echo "Current ip rules:"
          ip rule show
          echo "-------------";
          echo "Current main routing table:"
          ip route show table main
          echo "-------------";
          echo "Current marked routing table:"
          ip route show table marked
          echo "-------------";
        '';
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };
      };
    })
  ];
}
