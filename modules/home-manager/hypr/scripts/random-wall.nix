{ pkgs }:
pkgs.writeShellScriptBin "random-wall" ''
  if [ -z "$(pidof hyprpaper)" ]; then
    hyprpaper;
  fi
  dir=~/Wallpapers/
  wall=$(fd . $dir | shuf -n 1)
  hyprctl hyprpaper unload all
  hyprctl hyprpaper preload "$wall"
  hyprctl hyprpaper wallpaper eDP-1,"$wall"
''
