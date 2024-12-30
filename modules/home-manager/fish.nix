{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    shellAbbrs = {
      # Handy change dir shortcuts
      ".." = "z ..";
      "..."= "z ../..";
      ".3" = "z ../../..";
      ".4" = "z ../../../..";
      ".5" = "z ../../../../..";
      mkdir = "mkdir -p";
      cat = "bat";
      conf = "nvim ~/nix-config/nixos/configuration.nix";
      home = "nvim ~/nix-config/home-manager/home.nix";
      flake = "nvim ~/nix-config/flake.nix";
      fastfetch = "fastfetch --load-config examples/13.jsonc";
      c = "exit";
    };
    shellAliases = {
      # List Directory
      l = "eza -lh  --icons=auto"; # long list
      ls = "eza -1   --icons=auto"; # short list
      ll = "eza -lha --icons=auto --sort=name --group-directories-first"; # long list all
      ld = "eza -lhD --icons=auto"; # long list dirs
      lt = "eza --icons=auto --tree"; # list folder as tree
    };
    shellInitLast = ''
      enable_transience
      zoxide init fish | source
    '';
  };
}
