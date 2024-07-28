# home/programs/git.nix
{
  pkgs,
  lib,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "Fred Amaral";
    userEmail = "fred@fredamaral.com.br";

    # Define useful Git aliases for common operations
    aliases = {
      # Shortened versions of common commands
      ci = "commit";
      co = "checkout";
      s = "status";
      sw = "switch";
      p = "pull";
      f = "fetch";
      d = "diff";
      dc = "diff --cached";
      b = "branch";
      l = "log";
      mg = "merge";
      rb = "rebase";
      cp = "cherry-pick";
      res = "restore";
      resta = "restore --staged";

      # Useful listing commands
      branches = "branch -a"; # List all branches (local and remote)
      remotes = "remote -v"; # List all remotes with their URLs
      tags = "tag -l"; # List all tags
    };

    extraConfig = {
      # Automatically set up remote tracking for new branches
      push.autoSetupRemote = true;

      # Set the default branch name for new repositories
      init.defaultBranch = "main";
    };
  };

  # GitHub CLI configuration
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
    extensions = with pkgs; [
      # Add GitHub CLI extensions here
      # Note: Limited options available by default
      # TODO: Look into OSPO tools like gh-net, gh-sbom
      gh-eco
      gh-copilot
    ];
    settings = {
      # Add any custom GitHub CLI settings here
    };
  };

  # GitHub Dashboard configuration (gh-dash)
  programs.gh-dash = {
    enable = true;
    settings = {
      # Configure Pull Request sections and filters
      prSections = [
        {
          title = "PR Created";
          filters = "is:open author:@me";
        }
        {
          title = "PR to Reviews";
          filters = "is:open review-requested:@me";
        }
        {
          title = "PR Involved";
          filters = "is:open involves:@me -author:@me";
        }
      ];
      # Configure Issue sections and filters
      issuesSections = [
        {
          title = "Created";
          filters = "is:open author:@me";
        }
        {
          title = "Assigned";
          filters = "is:open assignee:@me";
        }
        {
          title = "Involved";
          filters = "is:open involves:@me -author:@me";
        }
      ];
    };
  };
}
