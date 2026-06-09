{pkgs, ...}: {
  services.swayidle = let
    lockCmd = "${pkgs.waylock}/bin/waylock";
    suspendCmd = "${pkgs.systemd}/bin/systemctl suspend";
    display = status: "${pkgs.wlopm}/bin/wlopm --${status} '*'";
  in {
    enable = true;
    events = {
      before-sleep = lockCmd;
      lock = lockCmd;
      after-resume = display "on";
      unlock = display "on";
    };
    timeouts = [
      {
        timeout = 150;
        command = lockCmd;
      }
      {
        timeout = 210;
        command = display "off";
        resumeCommand = display "on";
      }
      {
        timeout = 260;
        command = suspendCmd;
      }
    ];
  };
}
