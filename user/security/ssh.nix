{
  pkgs,
  userSettings,
  ...
}: let
  onePassPath = "~/.1password/agent.sock";
in {
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *.github.com
        IdentityAgent ${onePassPath}
    '';
  };
}
