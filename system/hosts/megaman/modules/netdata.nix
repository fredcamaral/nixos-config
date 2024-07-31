{
  config,
  lib,
  pkgs,
  ...
}: {
  services.netdata = {
    enable = true;
    config = {
      global = {
        "memory mode" = "dbengine";
        "page cache size" = 32;
        "dbengine disk space" = 256;
      };
      "cloud" = {
        "cloud base url" = "https://app.netdata.cloud";
        "claim token" = "prTEyXykQ1SpD-FlO43VLji8qCSMzRF8VR-VK1dG1u2PQZFjEL9QzYLhHKmzTloBmg99U6TVYCi7hceHQh65TiFrJx3IUSQRI32Gz5g0k2qYtanZ_Mf7B3jCYONIKMVrPauHUmE";
        "claim rooms" = "7b62d589-0a65-4884-83d1-90e4702157ed";
      };
      "plugin:proc" = {
        "cpu" = "yes";
        "diskstats" = "yes";
        "filesystem" = "yes";
        "loadavg" = "yes";
        "meminfo" = "yes";
        "netdev" = "yes";
        "stat" = "yes";
        "vmstat" = "yes";
        "interrupts" = "yes";
        "/proc/sys/kernel/random/entropy_avail" = "yes";
      };
      "plugin:systemd" = {
        "update every" = 1;
      };
      "plugin:systemd:units" = {
        "logind.service" = "yes";
      };
    };
  };

  # Open firewall ports for Prometheus and Grafana
  networking.firewall.allowedTCPPorts = [
    19999 # netdata
  ];

  # Add aliases for starting and stopping the monitoring services
  environment.shellAliases = {
    start-monitoring = "sudo systemctl start netdata";
    stop-monitoring = "sudo systemctl stop netdata";
    restart-monitoring = "sudo systemctl restart netdata";
  };
}
