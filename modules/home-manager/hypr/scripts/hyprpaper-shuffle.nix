{ pkgs }:
pkgs.writeShellScriptBin "hyprpaper-shuffle" ''
  dir=~/Wallpapers/
  wall=$(fd . $dir | shuf -n 1)
  cache=""
  while true; do
    if [ -z $(pidof hyprpaper) ]; then
      hyprpaper
    fi
    if [[ $cache == $wall ]]; then
      wall=$(fd . $dir | shuf -n 1)
    else
      cache=$wall
      hyprctl hyprpaper unload all
      hyprctl hyprpaper preload "$wall"
      hyprctl hyprpaper wallpaper eDP-1,"$wall"
    fi
    sleep 75 #2.5min
  done
''
