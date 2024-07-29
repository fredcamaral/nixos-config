{
  config,
  lib,
  pkgs,
  ...
}: let
  amdgpu_exporter = pkgs.writeScriptBin "amdgpu_exporter" ''
    #!${pkgs.bash}/bin/bash
    while true; do
      echo "# HELP amdgpu_temperature GPU temperature in celsius"
      echo "# TYPE amdgpu_temperature gauge"
      echo -n "amdgpu_temperature "
      cat /sys/class/drm/card0/device/hwmon/hwmon*/temp1_input | awk '{print $1/1000}'

      echo "# HELP amdgpu_fan_speed GPU fan speed percentage"
      echo "# TYPE amdgpu_fan_speed gauge"
      echo -n "amdgpu_fan_speed "
      cat /sys/class/drm/card0/device/hwmon/hwmon*/fan1_input | awk '{print $1}'

      sleep 5
    done
  '';

  grafanaPrometheusDataSource = pkgs.writeText "prometheus-datasource.yml" ''
    apiVersion: 1

    datasources:
    - name: PrometheusMegaman
      type: prometheus
      access: proxy
      url: http://localhost:${toString config.services.prometheus.port}
      isDefault: true
  '';
in {
  services = {
    # netdata is a real-time performance monitoring solution
    netdata = {
      enable = true;
      config = {
        global = {
          "memory mode" = "ram";
        };
      };
    };

    # Prometheus and Grafana are a powerful combination for monitoring and
    prometheus = {
      enable = true;
      port = 4000;

      exporters = {
        node = {
          enable = true;
          enabledCollectors = [
            "cpu"
            "diskstats"
            "filesystem"
            "loadavg"
            "meminfo"
            "netdev"
            "stat"
            "time"
            "vmstat"
            "systemd"
            "logind"
            "interrupts"
            "ksmd"
          ];
          port = 4002;
        };
        systemd = {
          enable = true;
          port = 4003;
        };
      };

      scrapeConfigs = [
        {
          job_name = "node";
          static_configs = [
            {
              targets = ["localhost:${toString config.services.prometheus.exporters.node.port}"];
            }
          ];
        }
        {
          job_name = "systemd";
          static_configs = [
            {
              targets = ["localhost:${toString config.services.prometheus.exporters.systemd.port}"];
            }
          ];
        }
        {
          job_name = "netdata";
          static_configs = [
            {
              targets = ["localhost:19999"];
            }
          ];
          metrics_path = "/api/v1/allmetrics";
          params = {
            format = ["prometheus"];
          };
        }
        {
          job_name = "amdgpu";
          static_configs = [
            {
              targets = ["localhost:9004"];
            }
          ];
          metrics_path = "/metrics";
          scrape_interval = "5s";
        }
      ];
    };

    grafana = {
      enable = true;
      settings = {
        server = {
          http_port = 4001;
          http_domain = "grafana.local";
          http_addr = "127.0.0.1";
        };
        security = {
          admin_user = "admin";
          admin_password = "admin";
        };
      };
      provision = {
        enable = true;
        datasources = {
          settings = {
            datasources = [
              {
                name = "Prometheus";
                type = "prometheus";
                url = "http://localhost:${toString config.services.prometheus.port}";
                isDefault = true;
              }
            ];
          };
        };
      };
    };
  };

  # Open firewall ports for Prometheus and Grafana
  networking.firewall.allowedTCPPorts = [
    config.services.prometheus.port
    config.services.grafana.settings.server.http_port
    config.services.prometheus.exporters.node.port
    config.services.prometheus.exporters.systemd.port
    9004 # amdgpu_exporter
    19999 # netdata
  ];

  # Install additional utilities
  environment.systemPackages = with pkgs; [
    prometheus
    prometheus-node-exporter
    grafana
    amdgpu_exporter # Custom AMDGPU exporter script
  ];

  # Start the custom AMDGPU exporter
  systemd.services.amdgpu_exporter = {
    description = "AMDGPU Exporter for Prometheus";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "${amdgpu_exporter}/bin/amdgpu_exporter | ${pkgs.prometheus}/bin/prometheus-web-handler --web.listen-address=:9004";
      Restart = "always";
    };
  };

  # Add aliases for starting and stopping the monitoring services
  environment.shellAliases = {
    start-monitoring = "sudo systemctl start prometheus grafana netdata";
    stop-monitoring = "sudo systemctl stop prometheus grafana netdata";
    restart-monitoring = "sudo systemctl restart prometheus grafana netdata";
  };
}
