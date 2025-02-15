{lib}:
{
  programs.waybar = {
    enable = true;
    settings = lib.importJSON ./config.jsonc;
  };
}
