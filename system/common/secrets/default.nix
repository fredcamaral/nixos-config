{
  config,
  hostname,
  ...
}: {
  age = {
    identityPaths = ["${config.users.users.fredamaral.home}/repos/.secrets/${hostname}.txt"];

    secrets."${hostname}-tailscale-auth" = {
      file = "${config.users.users.fredamaral.home}/repos/.secrets/${hostname}-tailscale-auth.age";

      owner = "root";
      group = "root";
      mode = "0400";
    };
  };
}
