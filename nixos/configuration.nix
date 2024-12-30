# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
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
      allowUnfreePredicate = _: true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
      auto-optimise-store = true;
      allowed-users = ["khang"];
      trusted-substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  # Use the systemd-boot EFI loader
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "intel_idle.max_cstate=2"
      "mitigations=off"
      "sysrq_always_enabled=1"
    ];
    # extraModprobeConfig = ''
    #   options ath9k nohwcrypt=1
    # '';
    # supportedFilesystems = [ "ntfs" ];
  };
  # fileSystems."/home/khang/win11" = {
  #   device = "/dev/disk/by-uuid/2CFE0EB6FE0E787A";
  #   fsType = "ntfs-3g";
  #   options = [ "rw" "uid=1000" ];
  # };
  fileSystems."/home/khang/arch" = {
    device = "/dev/disk/by-uuid/ee841478-ec1b-4070-b6ba-f9fe7d7d42ff";
    # fsType = "ext4";
    # options = [ "rw" "uid=1000" ];
  };
  fileSystems."/home/khang/stuff" = {
    device = "/dev/disk/by-uuid/8301-CD6A";
    fsType = "vfat";
    options = ["rw" "uid=1000"];
  };

  time.timeZone = "Asia/Ho_Chi_Minh";

  hardware.graphics.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
    config.hyprland.default = [
      "hyprland"
      "gtk"
    ];
    # xdgOpenUsePortal = true;
  };
  networking = {
    hostName = "laptop";
    networkmanager.enable = true;
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
    #media-session.enable = true;
    wireplumber.enable = true;
  };

  users = {
    groups.uinput.members = ["khang"];
    users.khang = {
      initialPassword = "khang";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = ["wheel" "network" "input"];
    };
  };

  environment.systemPackages = with pkgs; [
    neovim
    where-is-my-sddm-theme
    nh
  ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n = {
    extraLocaleSettings = {
      LC_ADDRESS = "vi_VN";
      LC_IDENTIFICATION = "vi_VN";
      LC_MEASUREMENT = "vi_VN";
      LC_MONETARY = "vi_VN";
      LC_NAME = "vi_VN";
      LC_NUMERIC = "vi_VN";
      LC_PAPER = "vi_VN";
      LC_TELEPHONE = "vi_VN";
      LC_TIME = "vi_VN";
    };

    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [fcitx5-unikey];
      fcitx5.waylandFrontend = true;
    };
  };

  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      nerd-fonts.fira-code
    ];
    fontconfig = {
      defaultFonts = {
        serif = [
          "Noto Serif"
        ];
        sansSerif = [
          "Noto Sans"
        ];
        monospace = [
          "FiraCode Nerd Font"
        ];
      };
    };
  };

  console = {
    font = "ter-114b";
    keyMap = "us";
    packages = with pkgs; [
      terminus_font
    ];
  };

  virtualisation.waydroid.enable = false;

  programs = {
    hyprland.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-volman
        thunar-archive-plugin
        thunar-media-tags-plugin
      ];
    };
    xfconf.enable = true;
    nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep 5 --keep-since 7d";
      };
    };
    xwayland.enable = true;
    nm-applet.enable = true;
    starship.enable = true;
    fish.enable = true;
    bash = {
      interactiveShellInit = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      viAlias = true;
    };
    gnupg = {
      agent = {
        enable = true;
      };
    };
  };

  security.pam.services.hyprlock = {};

  services = {
    displayManager = {
      enable = true;
      sddm = {
        enable = true;
        theme = pkgs.lib.mkForce "where_is_my_sddm_theme";
        wayland.enable = true;
        package = pkgs.lib.mkForce pkgs.kdePackages.sddm;
        extraPackages = with pkgs;
          lib.mkForce [
            #libsForQt5.qt5.qtgraphicaleffects
            kdePackages.plasma5support
          ];
      };
      defaultSession = "hyprland";
      # autoLogin = {
      #   enable = true;
      #  user = "khang";
      # };
    };
    gvfs.enable = true;
    tumbler.enable = true;
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      # Opinionated: forbid root login through SSH.
      PermitRootLogin = "no";
      # Opinionated: use keys only.
      # Remove if you want to SSH using passwords
      PasswordAuthentication = false;
    };
  };

  environment.sessionVariables = {
    XDG_SESSION_DESKTOP = "Hyprland";
    GDK_BACKEND = "wayland";
    GTK_USE_PORTAL = "1";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    NIXOS_OZONE_WL = "1";
    FLAKE = "/home/khang/nix-config/";
    EDITOR = "nvim";
    GCM_CREDENTIAL_STORE = "gpg";
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
