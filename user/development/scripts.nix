{pkgs, ...}: {
  home.packages = [
    (
      pkgs.writeShellApplication {
        name = "devserver";
        runtimeInputs = with pkgs; [entr];
        text = builtins.readFile ./scripts/devserver.sh;
      }
    )
  ];
}
