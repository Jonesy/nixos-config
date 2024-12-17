{config, ...}: {
  programs.swaylock = {
    enable = true;
    settings = {
      color = "211e20";
      font-size = 24;
      indicator-idle-visible = true;
      indicator-radius = 120;
      line-color = "e3e3e3";
      show-failed-attempts = true;
      image = "${config.home.homeDirectory}/.dotfiles/wallpaper.jpg";
    };
  };
}
