{
  config,
  pkgs,
  userSettings,
  ...
}: {
  home.packages = [pkgs.git];
  programs.git = {
    enable = true;
    userName = userSettings.fullName;
    userEmail = userSettings.email;
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "nvim";
    };
  };
}
