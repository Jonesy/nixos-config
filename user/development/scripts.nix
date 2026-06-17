{pkgs, ...}: {
  home.packages = [
    (
      pkgs.writeShellApplication {
        name = "devserver";
        runtimeInputs = with pkgs; [entr];
        text = builtins.readFile ../../scripts/devserver.sh;
      }
    )
    (
      pkgs.writeShellApplication {
        name = "display_battery";
        text = builtins.readFile ../../scripts/display_battery.sh;
      }
    )
    (
      pkgs.writeShellApplication {
        name = "display_brightness";
        text = builtins.readFile ../../scripts/display_brightness.sh;
      }
    )
    (
      pkgs.writeShellApplication {
        name = "display_cpu";
        text = builtins.readFile ../../scripts/display_cpu.sh;
      }
    )
    (
      pkgs.writeShellApplication {
        name = "display_wifi";
        text = builtins.readFile ../../scripts/display_wifi.sh;
      }
    )
    (
      pkgs.writeShellApplication {
        name = "display_volume";
        text = builtins.readFile ../../scripts/display_volume.sh;
      }
    )
  ];
}
