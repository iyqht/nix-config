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
    archiver
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
    gh
    pass-wayland
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.gpg.enable = true;

  services = {
    gnome-keyring.enable = true;
    gpg-agent.enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "blue";
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = pkgs.lib.mkForce "Bibata-Modern-Ice";
      size = 20;
    };
    iconTheme = {
      package = pkgs.catppuccin-papirus-folders;
      name = "Papirus-Dark";
    };
    # gtk3.extraConfig = {
    #   Settings = ''
    #     gtk-application-prefer-dark-theme=1
    #   '';
    # };
    # gtk4.extraConfig = {
    #   Settings = ''
    #     gtk-application-prefer-dark-theme=1
    #   '';
    # };
  };

  qt = {
    enable = true;
    style.name = "kvantum";
    platformTheme.name = "kvantum";
  };

  home.pointerCursor = {
    package = pkgs.lib.mkForce pkgs.bibata-cursors;
    name = pkgs.lib.mkForce "Bibata-Modern-Ice";
    size = 20;
    gtk.enable = true;
    x11.enable = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
