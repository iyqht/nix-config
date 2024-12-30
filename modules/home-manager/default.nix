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
    # ./hypr/default.nix
    ./nvim.nix
<<<<<<< HEAD
    # ./fish.nix
    # ./git.nix
=======
    ./fish.nix
<<<<<<< HEAD
    ./git.nix
>>>>>>> parent of 6b5bf9b (comment git.nix in modules/home-manager/default.nix)
=======
    # ./git.nix
>>>>>>> parent of c8c6d60 (uncomment git.nix in modules/home-manager/default.nix)
  ];
  xdg.configFile = {
    "starship.toml".source = config.lib.file.mkOutOfStoreSymlink "${path}starship.toml";
    "waybar" = {
      # enable = false;
      source = config.lib.file.mkOutOfStoreSymlink "${path}waybar";
      recursive = true;
    };
    "kanata" = {
      source = ./kanata/kanata.kbd;
      recursive = true;
    };
  };
}
