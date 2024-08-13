# direnv: Unclutter your .profile!
{...}: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    # Integrations
    enableZshIntegration = true;
  };
}
