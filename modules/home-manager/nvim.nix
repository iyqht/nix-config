{
  config,
  pkgs,
  ...
}:
{
	xdg.configFile = {
		"nvim" = {
			source = config.lib.file.mkOutOfStoreSymlink "/home/khang/nix-config/modules/home-manager/nvim";
			recursive = true;
		};
	};
	home.packages = with pkgs; [
		lua-language-server
		stylua
		nixd
		alejandra
		deadnix
		statix
		nixpkgs-lint-community
    hyprls
	];
}
