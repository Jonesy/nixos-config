# NixOS Config

NixOS config of a life-long Mac user, so it's very much a work in progress.

## Motivations

This is a developer-focused config, it has been birthed out of a need to be able to hop from different projects with different libraries and versions. Managing
different versions of libraries, needing to clog my system with extra packages
for a quick project and so on have been a long running frustration and NixOS
really has helped aleviate those common problems.

## Configuration

This configuration uses [flakes](https://nixos.wiki/wiki/Flakes) and [Home
Manager](https://nix-community.github.io/home-manager/). After a few tries I got
it to work by using the [home-manager
flakes](https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-standalone)
approach.

## Updating

```sh
sudo nix-channel update;
sudo nix flake update;
sudo nixos-rebuild switch --flake .;
home-manager switch --flake .;
```

### Todos Short Term

- [x] Break up config into separate modules
- [ ] Write blog post tutorial
- [x] Clean up project structure
- [ ] Allow for different users to install (not just me)
- [ ] Add snippets in README

### Todos Long Term

- [x] Structure for a second NixOS box and MacBook
- [x] Try out Hyprland or a comparable tiling manager

### Reading Material

- [Writing your own flakes](https://serokell.io/blog/practical-nix-flakes#writing-your-own)
- [Connecting to Wifi](https://www.makeuseof.com/connect-to-wifi-with-nmcli/)
- [Unofficial Cookbook](https://nixos-and-flakes.thiscute.world/)
