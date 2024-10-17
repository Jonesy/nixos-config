# TODO: try transitioning to
# https://github.com/ErikReider/SwayNotificationCenter for notifications
{ ... }: {
  imports = [
    ./mako.nix
    ./wofi
    ./waybar
  ];
}
