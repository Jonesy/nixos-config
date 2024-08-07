{ config, pkgs, lib, userSettings, ... }:

{
  home.username = "jjones";
  home.homeDirectory = "/home/jjones";
  home.sessionVariables.GTK_THEME = "Orchis-Dark-Compact";
  programs.home-manager.enable = true;

  imports = [
    ./user/packages/git/git.nix
    ./user/packages/term
    ./user/packages/desktop/wayland
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # Sway + Wayland
  # Good reference: https://github.com/Enzime/dotfiles-nix/blob/ba28c8e0902bbb3e1fc9b4d04cd8b4804e8ddcc4/modules/sway.nix#L159
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    systemd.enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
      output = {
        "Virtual-1" = {
          mode = "1920x1080@60Hz";
          adaptive_sync = "on";
        };
      };
      fonts = {
        size = 14.0;
      };
      assigns = {
        "1: Terminal" = [{ class = "^Alacritty$"; }];
        "10: Slack" = [{ class = "^Slack$"; }];
        "9: Password" = [{ class = "^1Password$"; }];
      };
      startup = [
        { command = lib.getExe' config.services.mako.package "mako"; }
        {
          command =
            "swaybg --image ${config.home.homeDirectory}/.dotfiles/wallpaper.jpg --output \"*\"";
        }
        # TODO: Hold off on 1password until ready to mess with lock
        # { command = "1password --silent"; }
        {
          command = "systemctl --user restart waybar";
          always = true;
        }
      ];
      keybindings =
        let
          mod =
            config.wayland.windowManager.sway.config.modifier;
          wofi = lib.getExe pkgs.wofi;
          pamixer = lib.getExe pkgs.pamixer;
          brightnessctl = lib.getExe pkgs.light;
        in
        lib.mkOptionDefault {
          "${mod}+d" = "exec ${wofi} --show run --prompt=Run";
          # Volume
          "XF86AudioRaiseVolume" = "exec ${pamixer} --increase 5";
          "XF86AudioLowerVolume" = "exec ${pamixer} --decrease 5";
          "XF86AudioMute" = "exec ${pamixer} --toggle-mute";
          "XF86AudioMicMute" = "exec ${pamixer} --default-source --toggle-mute";
          # Brightness
          "XF86MonBrightnessDown" = "exec ${brightnessctl} -U 10";
          "XF86MonBrightnessUp" = "exec ${brightnessctl} -A 10";
          # "${mod}+l" = "exec ${wofi} --show run --prompt=Run";
        };
      input."type:touchpad" = {
        natural_scroll = "enabled";
      };
      bars = [ ];
      window = {
        titlebar = true;
      };
      colors =
        let
          main = "#211e20";
          secondary = "#555568";
          light = "#a0a08b";
          dark = "#e9efec";
        in
        {
          focused = {
            background = secondary;
            border = secondary;
            childBorder = secondary;
            text = dark;
            indicator = dark;
          };
          unfocused = {
            background = main;
            border = secondary;
            childBorder = dark;
            text = light;
            indicator = main;
          };
          focusedInactive = {
            background = main;
            border = secondary;
            childBorder = dark;
            text = light;
            indicator = main;

          };
        };
    };
  };

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

  # Sway Idle 
  # ----------------
  systemd.user.services.swayidle.Install.WantedBy = [ "sway-session.target" ];

  services.swayidle =
    let
      lockCmd = "${pkgs.swaylock}/bin/swaylock -c 000000 -fF";
      sessionCmd = "${pkgs.systemd}/bin/loginctl lock-session";
      suspendCmd = "${pkgs.systemd}/bin/systemctl suspend";
    in
    {
      enable = true;
      extraArgs = [ "-w" ];
      systemdTarget = "sway-session.target";
      events = [
        {
          event = "before-sleep";
          command = sessionCmd;
        }
        { event = "lock"; command = lockCmd; }
      ];
      timeouts = [
        { timeout = 300; command = lockCmd; }
        { timeout = 600; command = suspendCmd; }
      ];
    };



  # GTK Settings
  gtk = {
    enable = true;
    theme = {
      name = "Orchis-Dark-Compact";
      package = pkgs.orchis-theme;
      # name = "Catppuccin-Macchiato-Compact-Pink-Dark";
      # package = pkgs.catppuccin-gtk.override {
      #   accents = [ "blue" ];
      #   size = "compact";
      #   tweaks = [ "rimless" "black" ];
      #   variant = "macchiato";
      # };
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  # Now symlink the `~/.config/gtk-4.0/` folder declaratively:
  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  dconf.settings = {
    # "org/gnome/desktop/interface" = {
    #   scaling-factor = lib.hm.gvariant.mkUint32 2;
    # };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "dash-to-panel@jderose9.github.com"
      ];
      favorite-apps = [
        "alacritty.desktop"
        "firefox.desktop"
      ];
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Orchis-Dark-Compact";
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  home.packages = with pkgs; [
    apostrophe
    firefox
    vivaldi
    chromium
    signal-desktop
    _1password
    _1password-gui
    slack
    eza
    bat
    yazi
    zoxide

    # GNOME
    gnomeExtensions.user-themes
    gnomeExtensions.dash-to-panel
    palenight-theme

    # Window Manager
    wl-clipboard
    shotman
    wofi
    swaybg

    # Development
    lazygit
    gh
    glab
    gcc
    gnumake42
    ripgrep
    fd
    xclip
    any-nix-shell
    nix-prefetch
    glow # Markdown preview

    # NeoVim
    neovim
    tree-sitter
    nodejs_20

    # LSPs
    nil
    gopls
    bash-language-server
    lua-language-server
    rust-analyzer
    nodePackages_latest.typescript-language-server
    zls
    vscode-langservers-extracted
    templ

    # Linters
    lua54Packages.luacheck

    # Formatters
    stylua
    prettierd
    nixpkgs-fmt
    shellharden

    # Fonts
    (pkgs.nerdfonts.override {
      fonts = [
        "IBMPlexMono"
        "Iosevka"
        "IosevkaTerm"
        "JetBrainsMono"
        "SpaceMono"
      ];
    })
  ];

  fonts.fontconfig.enable = true;

  # fonts.fontconfig.localConf = ''
  #   <?xml version='1.0'?>
  #   <!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
  #   <fontconfig>
  #     <dir>~/.nix-profile/share/fonts/</dir>
  #   </fontconfig>
  # '';

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  nixpkgs.config.allowUnfree = true;
}
