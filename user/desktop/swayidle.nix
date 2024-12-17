{pkgs, ...}: {
  systemd.user.services.swayidle.Install.WantedBy = ["sway-session.target"];

  services.swayidle = let
    lockCmd = "${pkgs.swaylock}/bin/swaylock -c 000000 -fF";
    sessionCmd = "${pkgs.systemd}/bin/loginctl lock-session";
    suspendCmd = "${pkgs.systemd}/bin/systemctl suspend";
  in {
    enable = true;
    extraArgs = ["-w"];
    systemdTarget = "sway-session.target";
    events = [
      {
        event = "before-sleep";
        command = sessionCmd;
      }
      {
        event = "lock";
        command = lockCmd;
      }
    ];
    timeouts = [
      {
        timeout = 300;
        command = lockCmd;
      }
      {
        timeout = 600;
        command = suspendCmd;
      }
    ];
  };
}
