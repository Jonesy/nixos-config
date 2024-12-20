{ config, pkgs, ... }:
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Sway Setup
  # programs.sway.enable = true;
  security.polkit.enable = true;
  security.pam.services.swaylock = { };
  hardware.graphics.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gedit # text editor
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    epiphany # web browser
    geary # email reader
    gnome-characters
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
    yelp # Help view
    gnome-contacts
    gnome-initial-setup
  ]);

  programs.dconf.enable = true;

  # Configure keymap in X11
  # services.xserver = {
  #   layout = "us";
  #   xkbVariant = "";
  # };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Sceensharing
  # services.dbus.enable = true;
  # xdg.portal = {
  #   enable = true;
  #   wlr.enable = true;
  #   extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  # };

  # Enable sound with pipewire.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jjones = {
    isNormalUser = true;
    description = "Joshua Jones";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    packages = [ ];
  };
  programs.light.enable = true;

  nixpkgs.config.allowUnfree = true;

  # Environmental
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    zsh
    git
    gnome-tweaks
    mako
    (
      pkgs.writeShellApplication {
        name = "devserver";
        runtimeInputs = with pkgs; [ entr ];
        text = builtins.readFile ./scripts/devserver.sh;
      }
    )
  ];

  # Set up fish as default shell
  environment.shells = with pkgs; [ fish ];
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "jjones" ];
  };

  fonts.fontDir.enable = true;

  environment.sessionVariables = { };
  environment.shellAliases = { };

  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [
          "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
        ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (defsrc
            caps a s d f j k l ; spc
          )
          (defvar
            tap-time 150
            hold-time 200
          )
          (defalias
            caps (tap-hold $tap-time $hold-time esc lctl)
            a (tap-hold $tap-time $hold-time a lctl)
            s (tap-hold $tap-time $hold-time s lsft)
            d (tap-hold $tap-time $hold-time d lalt)
            f (tap-hold $tap-time $hold-time f lmet)
            j (tap-hold $tap-time $hold-time j rmet)
            k (tap-hold $tap-time $hold-time k ralt)
            l (tap-hold $tap-time $hold-time l rsft)
            ; (tap-hold $tap-time $hold-time ; rctl)
            spc (tap-hold $tap-time $hold-time spc (layer-while-held arrows))
          )
          (deflayer (base) 
            @caps @a @s @d @f @j @k @l @; @spc
          )
          (deflayermap (arrows)
            h left
            j down
            k up
            l right
          )
        '';
      };
    };
  };
  # Enable "experimental" flakes support
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

