# NixOS Multi-computer configuration instructions

# After Successful Installation

- Add Vim, Git and enable flakes in `/etc/nixos/configuration.nix`, flakes with
  `nix.settings.experimental-features = [ "nix-command" "flakes" ];`, and `sudo
nixos-rebuild switch .`
- Make a `~/.dotfiles` directory and copy the `/etc/nixos` files to a
  `profiles/<hardware-name>` folder
- Init a new flake in `.dotfiles` and configure a bare bone flake to load the
  `hostName` from `configuration.nix` and `sudo nixos-rebuild switch --flake .`
- Add some utility functions

## Install Home Manager

- `nix run home-manager/master -- init`, but not switch. Copy files to this
  directory.
- Copy the flake `inputs.home-manager` and `homeConfigurations` to the current
  `flake.nix`.
- Move home into its own directory. I'll have a linux and and mac one.
- Update the home file, run `sudo nixos-rebuild switch --flake .` to install
  home manager.

## Install Git via Home Manager

Create an `/user/apps/git/` directory, add a `git.nix` file and set the
necessary config, using `flake.userSettings` to configure global values like
email and user name.

## Install Fish

yeah yeah, I use fish. Add a `/user/shell/fish.nix` and set up base
configuration there. As per wiki add `programs.fish.enable = true;` to profile
`configuration.nix` and set it as the `defaultUserShell`.

## Install a Terminal

Going with Alacritty but will probably install Wezterm. Set up to add Fish as
default shell.

## Install 1Password

!> [!IMPORTANT]

> Install `services.openssh.enable = true;`

Using HM, create a new `1password.nix` and add `pkgs._1password-cli` and
`pkgs._1password-gui`. Add a new `security/ssh.nix` and insert the 1Password
agent there. Also make sure to override `allowUnfreePredicate` for the 2 apps so
they will install. Sign in and you're off to the races!

!> [!NOTE]

> If 1Password isn't catching the git request, update the hosts to be domain
> specific instead of trying to \*

## Sway time

Follow home manager instructions for installing sway from wiki, also not going
Systemd route this time.

A great resources for setting up Sway https://www.drakerossman.com/blog/wayland-on-nixos-confusion-conquest-triumph

Also ran into an issue with 1Password when switching to Wayland where SSH
stopped working, this was fixed by setting the hosts to `*`.

Also hit a snag where electron apps were at a lower resolution, this was fixed
by enabling `xdg.portal` with `xdg-desktop-portal`, `xdg-desktop-portal-gtk` and
`xdg-desktop-portal-wlr`. There is an error about config I'll need to look into.

I also set these `environment.sessionVariables`:

```
NIXOS_OZONE_WL=1
MOX_ENABLE_WAYLAND=1
GDK_SCALE=2
```

I also applied the cursor fix as per the docs, turned on `gnome.keyring`

## Waybar

I turned on Waybar but it's not launching, `services.dbus.enable = true;` is
part of the fix, but I need to figure out which `portal.Desktop` I need to use.

Ran into an error where the Output wasn't configured correctly, make sure it's
being pointed at the correct port.
