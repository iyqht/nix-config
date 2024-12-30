{ pkgs }:
pkgs.writeShellScriptBin "random-wall" ''
  if [ -z "$(pidof hyprpaper)" ]; then
    hyprpaper;
  fi
  dir=~/Wallpapers/
  wall=$(fd . $dir | shuf -n 1)
  echo -e "preload = $wall\nwallpaper = eDP-1,$wall" > ~/.config/hypr/hyprpaper.conf
  hyprctl hyprpaper unload all
  hyprctl hyprpaper preload "$wall"
  hyprctl hyprpaper wallpaper eDP-1,"$wall"
''
