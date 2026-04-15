{
  config,
  pkgs,
  userSettings,
  ...
}: {
  home.packages = [pkgs.git];
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = userSettings.fullName;
        email = userSettings.email;
      };
      init.defaultBranch = "main";
      core.editor = "nvim";
    };
  };
}
