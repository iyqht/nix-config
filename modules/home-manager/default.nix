# Add your reusable NixOS modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  config,
  pkgs,
  ...
}: let
  path = "/home/khang/nix-config/modules/home-manager/";
in {
  # List your module files here
  # my-module = import ./my-module.nix;
  imports = [
    ./hypr/default.nix
    ./nvim.nix
    ./fish.nix
  ];
  xdg.configFile = {
    "starship.toml".source = config.lib.file.mkOutOfStoreSymlink "${path}starship.toml";
    "waybar" = {
      # enable = false;
      source = config.lib.file.mkOutOfStoreSymlink "${path}waybar";
      recursive = true;
    };
    "kanata/kanata.kbd" = {
      source = ./kanata/kanata.kbd;
      recursive = true;
    };
  };
}
