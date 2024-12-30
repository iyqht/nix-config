{pkgs, ...}: let
  random-wall = pkgs.writeShellScriptBin "random-wall" ''
    if [ -z "$(pidof hyprpaper)" ]; then
      hyprpaper;
    fi
    dir=/home/khang/Wallpapers/
    wall=$(fd . $dir | shuf -n 1)
    echo -e "preload = $wall\nwallpaper = eDP-1,$wall" > /home/khang/.config/hypr/hyprpaper.conf
    hyprctl hyprpaper unload all
    hyprctl hyprpaper preload "$wall"
    hyprctl hyprpaper wallpaper eDP-1,"$wall"
  '';
in {
  home.packages = [random-wall];

  systemd.user = {
    services.wallpaperRandomizer = {
      Install = {WantedBy = ["graphical-session.target"];};

      Unit = {
        Description = "Set random desktop background using hyprpaper";
        After = ["graphical-session-pre.target"];
        PartOf = ["graphical-session.target"];
      };

      Service = {
        Type = "oneshot";
        ExecStart = "${random-wall}/bin/random-wall";
        IOSchedulingClass = "idle";
      };
    };

    timers.wallpaperRandomizer = {
      Install = {WantedBy = ["timers.target"];};

      Unit = {Description = "Set random desktop background using hyprpaper on an interval";};

      Timer = {
        OnUnitActiveSec = "5m";
        # Unit = "wallpaperRandomizer.service";
      };
    };
  };
}
