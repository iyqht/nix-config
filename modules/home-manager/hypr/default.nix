{ config, pkgs, ... }:
let
  path = "/home/khang/nix-config/modules/home-manager/hypr/";
in
{
  home.packages = [
    (import ./scripts/hyprpaper-shuffle.nix { inherit pkgs; })
    (import ./scripts/gamemode.nix { inherit pkgs; })
    (import ./scripts/random-wall.nix { inherit pkgs; })
    (import ./scripts/whatsong.nix { inherit pkgs; })
    pkgs.hyprshade
    pkgs.hyprpaper
    pkgs.hypridle
    pkgs.hyprlock
  ];
  wayland.windowManager.hyprland.enable = true;

  xdg.configFile = {
    "hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink "${path}hyprland.conf";
    "hypr/hypridle.conf".source = config.lib.file.mkOutOfStoreSymlink "${path}hypridle.conf";
    "hypr/hyprlock.conf".source = config.lib.file.mkOutOfStoreSymlink "${path}hyprlock.conf";
    "hypr/hyprshade.toml".source = config.lib.file.mkOutOfStoreSymlink "${path}hyprshade.toml";
  };
}
