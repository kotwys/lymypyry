{ pkgs, ... }:

{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = builtins.attrValues {
        inherit (pkgs) fcitx5-mozc;
        inherit (pkgs.kdePackages) fcitx5-chinese-addons;
      };
    };
  };
}
