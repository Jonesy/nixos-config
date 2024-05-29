{ config, pkgs, lib, fonts, ... }:

{
  home.username = "jjones";
  home.homeDirectory = "/home/jjones";
  home.sessionVariables.GTK_THEME = "Orchis-Dark-Compact";

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
    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
      output = {
        "Virtual-1" = {
          mode = "1920x1080@60Hz";
        };
      };
      startup = [
        { command = lib.getExe' config.services.mako.package "mako"; }
        { command = "firefox"; }
      ];
      # TODO: Wire up wofi
      # menu = "\${pkgs.wofi}/bin/dmenu_path | \${pkgs.dmenu}/bin/dmenu | \${pkgs.findutils}/bin/xargs swaymsg exec --";
      keybindings =
        let
          modifier =
            config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          # "${modifier}+d" = "exec ${pkgs.wofi} --show run --prompt=Run";
        };
      input."type:touchpad" = {
        tap = "enabled";
        natural_scroll = "enabled";
      };
    };
    # exec,wofi --show run --xoffset=1670 --yoffset=12 --width=230px --height=984 --style=$HOME/.config/wofi.css --term=footclient --prompt=Run
    # extraConfig = ''
    #   input 1267:12792:ELAN067B:00_04F3:31F8_Touchpad {
    #       natural_scroll enabled
    #   }
    # '';
  };

  # Notifications Daemon
  services.mako.enable = true;
  services.mako.defaultTimeout = 5000;
  services.mako.backgroundColor = "#0d0c0c";
  services.mako.borderColor = "#e61f00";
  services.mako.padding = "10,5,10,10";

  # Waybar 
  programs.waybar.settings = [{
    # modules-left = [ "sway/workspaces" "sway/mode" ];
    # modules-center = [ "sway/window" ];
    # modules-right = [ "idle_inhibitor" "battery" "clock" "tray" ];
    # "sway/window" = { max-length = 50; };
    battery = {
      format = "{capacity}% {icon}";
      format-icons = [ "" "" "" "" "" ];
    };
    clock = {
      format = "{:%a %b %d %I:%M:%S %p}";
      interval = 1;
    };
    # idle_inhibitor = {
    #   format = "{icon}";
    #   format-icons = {
    #     activated = "";
    #     deactivated = "";
    #   };
    # };
  }];

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
    chromium
    signal-desktop
    _1password
    _1password-gui
    eza
    bat

    # GNOME
    gnomeExtensions.user-themes
    gnomeExtensions.dash-to-panel
    palenight-theme

    # Window Manager
    wl-clipboard
    shotman
    waybar
    wofi

    # Development
    alacritty
    starship
    git
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
    zellij
    tree-sitter
    nodejs_20

    # LSPs
    nil
    gopls
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

    # Fonts
    (pkgs.nerdfonts.override {
      fonts = [
        "IBMPlexMono"
        "Iosevka"
        "IosevkaTerm"
        "JetBrainsMono"
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
  programs.home-manager.enable = true;


  # TODO: Figure out font scaling, maybe I just install hyprland
  # https://hoverbear.org/blog/declarative-gnome-configuration-in-nixos/
  # see also https://github.com/Hoverbear-Consulting/flake/blob/f6a2afd6646508727578552c8620391f4ef02e36/users/ana/home.nix#L47
  # programs.dconf = {
  #   enable = true;
  #   programs.dconf.profiles.gdm.database = [{
  #     settings."org/gnome/desktop/interface".scaling-factor = lib.gvariant.mkUint32 2;
  #   }];
  # };
  # Program configs
  programs.alacritty = {
    enable = true;
    settings = {
      shell = {
        program = "fish";
        args = [ "--login" ];
      };
      font = {
        normal = {
          family = "IosevkaTerm Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "IosevkaTerm Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "IosevkaTerm Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "IosevkaTerm Nerd Font";
          style = "Bold Italic";
        };
        size = 16;
      };
      # TODO: Get my old MacOS CMD+K -> clear keybinding
    };
  };

  # See reference here: https://nixos.wiki/wiki/Fish
  programs.fish = {
    enable = true;
    shellAliases = {
      zj = "zellij";
      lg = "lazygit";
      ll = "eza -l --icons --header";
      lla = "eza -l -a --icons --header";
      cl = "clear";
      nd = "nix develop --command fish";
    };
  };

  programs.git = {
    enable = true;
    userName = "Joshua Jones";
    userEmail = "joshua@general-metrics.com";
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "nvim";
    };
  };

  programs.zellij = {
    enable = true;
    settings = {
      default_layout = "compact";
      default_shell = "fish";
      theme = "catpupuccin-mocha";
      copy_command = "xclip -selection clipboard";
    };
  };

  programs.starship = {
    enable = true;
  };

  programs.wofi = {
    enable = true;
    settings = {
      allow_markup = true;
      width = 250;
    };
    style = ''
      * {
        font-family: Iosevka, monospace;
      }
  
      window {
        background-color: #7c818c;
      }
    '';
  };
}
