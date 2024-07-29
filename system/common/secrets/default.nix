{config, ...}: {
  age = {
    identityPaths = ["${config.users.users.fredamaral.home}/repos/.secrets/megaman-tailscale.txt"];

    secrets.megaman-tailscale-auth = {
      file = "${config.users.users.fredamaral.home}/repos/.secrets/megaman-tailscale-auth.age";

      owner = "root";
      group = "root";
      mode = "0400";
    };
  };
}
