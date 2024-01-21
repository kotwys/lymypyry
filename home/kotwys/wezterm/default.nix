{ pkgs, ... }:

let
  mkTheme = pkgs.callPackage ./from-tilix.nix {};
in
{
  home.packages = [ pkgs.wezterm ];
  home.sessionVariables.XCURSOR_THEME = "Adwaita";

  xdg.configFile."wezterm/wezterm.lua".source = ./wezterm.lua;
  xdg.configFile."wezterm/colors/Base2Tone Motel Dark.toml".source =
    mkTheme {
      name = "Base2Tone Motel Dark";
      src = pkgs.fetchurl {
        url = "https://gitlab.com/drkrynstrng/base2tone-tilix/-/raw/ad39cdf465d563c6cfdfeb7bc007819da9c6c562/schemes/base2tone-motel-dark.json";
        sha256 = "07j1bw555aapfvni43y2jwirh4fxhxkkvgxd9ry1w62d1339y0q2";
      };
    };
}
