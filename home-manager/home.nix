# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./../modules/home-manager/default.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  home = {
    username = "khang";
    homeDirectory = "/home/khang";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim = {
  #   enable = true;
  #   vimAlias = true;
  #   viAlias = true;
  #   vimdiffAlias = true;
  # };
  home.packages = with pkgs; [
    firefox
    kitty
    eza
    waybar
    brightnessctl
    playerctl
    wlogout
    rofi-wayland
    ffmpegthumbnailer
    wl-clipboard
    cliphist
    imv
    vlc
    mpv
    pavucontrol
    fd
    ripgrep
    rar
    libsForQt5.qt5ct
    grim
    slurp
    swappy
    networkmanagerapplet
    catppuccin-qt5ct
    bat
    cpufetch
    jq
    fastfetch
    neovide
    gcc
    python3
    xfce.exo
    wcalc
    grim
    slurp
    swappy
    btop
    kanata
    fish
    zoxide
    cbonsai
    neo
    yazi
    bluez
    libgtop
    upower
    git
    gh
    pass-wayland
  ];

  # Enable home-manager and git
  programs = {
    home-manager.enable = true;
    git.enable = true;
    gpg.enable = true;
  };

  services = {
    gnome-keyring.enable = true;
    gpg-agent.enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  stylix = {
    enable = true;
    image = ../wall.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 20;
    };
    fonts = {
      monospace = {
        package = pkgs.fira-code;
        name = "FiraCode Nerd Font";
      };
    };
    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus Dark";
      light = "Papirus Light";
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
