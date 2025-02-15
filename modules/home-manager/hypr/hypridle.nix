{pkgs, ...}:
{
  home.packages = [ pkgs.hypridle ];
  services.hypridle = {
    enable = true;
  };
}
