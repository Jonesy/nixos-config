{ pkgs, userSettings, ... }: {
  home.packages = with pkgs; [ waybar ];
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        output = [
          "eDP-1"
          # "HDMI-A-1"
        ];
        modules-left = [ "sway/workspaces" "sway/mode" ];
        modules-center = [ "clock" ];
        modules-right = [ "tray" "network" "cpu" "battery" ];
        "sway/window" = { max-length = 50; };
        battery = {
          format = "<span color='#555568'>{icon}</span>  {capacity}%";
          format-charging = "<span color='#555568'> </span> {capacity}%";
          format-icons = [ "" "" "" "" "" ];
        };

        tray = {
          spacing = 4;
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
          format-icons = [ "" ];
        };

        pulseaudio = {
          format = " { icon } {volume}%";
          format-icons = [ "" "" "" ];
          format-muted = " {volume}% (Muted)";
          on-click = "pactl set-sink-mute 0 toggle";
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
      fontFamily = userSettings.fontFamilyTerm;
      fontSize = builtins.toString (builtins.floor (userSettings.fontSize + 1.0));
    };
    # style = ''
    #   * { 
    #     font-family: "IosevkaTerm Nerd Font", Helvetica, sans-serif;
    #     font-size: 14px;
    #   }

    #   window#waybar {
    #     background-color: #211e20;
    #   }

    #   #workspaces button {
    #     padding: 0 5px;
    #     margin: 5px;
    #     border-radius: 0;
    #     background-color: transparent;
    #   }

    #   #workspaces button.focused {
    #     color: #211e20;
    #     background-color: #a0a08b;
    #     
    #   }
    #   
    #   #clock, 
    #   #battery,
    #   #cpu,
    #   #memory,
    #   #temperature,
    #   #backlight,
    #   #network,
    #   #pulsuaudio,
    #   #custom-media,
    #   #tray,
    #   #mode, 
    #   #inhibitor {
    #     padding: 0 10px;
    #     margin: 0 5px;
    #   }

    #   #tray > .passive {
    #     color: #555568;
    #   }

    #   #tray > .needs-attention {
    #       color: #a0a08b;
    #   }
    # '';
  };
  programs.waybar.systemd.enable = true;
  programs.waybar.systemd.target = "sway-session.target";
}
