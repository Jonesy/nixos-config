{
  pkgs,
  userSettings,
  ...
}: {
  home.packages = with pkgs; [waybar];
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        output = [
          # "eDP-1"
          "HDMI-A-1"
        ];
        modules-left = ["sway/workspaces" "sway/mode"];
        modules-center = ["clock"];
        modules-right = ["tray" "pulseaudio" "network" "cpu" "battery"];
        "sway/window" = {max-length = 50;};

        tray = {
          spacing = 4;
        };

        battery = {
          format = "<span color='#555568'>{icon}</span> {capacity}%";
          format-charging = "<span color='#555568'>󰂄 </span> {capacity}%";
          format-icons = ["󰁺" "󰁼" "󰁿" "󰂁" "󰁹"];
        };

        network = {
          format-wifi = "<span color='#555568'> </span> {essid} <span color=\"#a0a08b\">{signalStrength}%</span>";
          format-ethernet = "  {ifname}: {ipaddr}/{cidr}";
          format-linked = "  {ifname} (No IP)";
          format-disconnected = "⚠ Disconnected ⚠";
          format-alt = "{essid} {signalStrength}%";
        };

        cpu = {
          format = "<span color='#555568'>{icon}</span>  {usage}%";
          format-icons = [""];
        };

        pulseaudio = {
          format = "<span color='#555568'>{icon}</span> {volume}%";
          format-source = "<span color='#555568'>{icon}</span> {volume}%";
          format-muted = "<span color='#555568'> </span> Muted";
          format-bluetooth = "<span color='#555568'>󰂰</span>";
          format-icons = ["" "" ""];
        };

        clock = {
          format = "{:%a %b %d %I:%M%p}";
          interval = 1;
        };

        tray.show-passive-items = true;
      };
    };
    style = pkgs.substituteAll {
      name = "style.css";
      src = ./style.css;
      fontFamily = userSettings.fontFamilyGui;
      fontSize = builtins.toString (builtins.floor (userSettings.fontSize + 1.0));
    };
  };
  # programs.waybar.systemd.enable = true;
  # programs.waybar.systemd.target = "sway-session.target";
}
