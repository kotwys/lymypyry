{ pkgs, ... }:

{
  networking.networkmanager.enable = true;

  i18n.defaultLocale = "ru_RU.UTF-8";
  time.timeZone = "Europe/Samara";
  console = {
    font = "latarcyrheb-sun16";
    keyMap = "us";
  };

  services.xserver = {
    enable = true;
    layout = "us,ru";
    xkbOptions = "grp:alt_shift_toggle,ctrl:swapcaps";
  };

  services.kdeconnect = { enable = true; };

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [ locals.epson_201401w ];
  };

  services.zerotierone.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.fish.enable = true;

  fonts = {
    fontconfig = {
      enable = true;
      hinting.autohint = true;
      defaultFonts = {
        sansSerif = [ "Noto Sans" "DejaVu Sans" "Noto Color Emoji" ];
        serif = [ "Noto Serif" "DejaVu Serif" "Noto Color Emoji" ];
        monospace = [ "Cascadia Code" "Noto Color Emoji" ];
      };
      localConf = ''
        <match target="pattern">
          <test qual="any" name="family"><string>-apple-system</string></test>
          <edit name="family" mode="prepend" binding="same">
            <string>Ubuntu</string>
          </edit>
        </match>
      '';
    };
    fonts = with pkgs; [
      open-sans
      noto-fonts
      noto-fonts-emoji
      ubuntu_font_family
      cascadia-code
    ];
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard # Needed for Neovim to be able to access clipboard
    firefox
    vlc
    libreoffice-fresh
    wget
    git
  ];

  users.users.kotwys = {
    createHome = true;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
    password = "welcome";
  };

  home-manager.users.kotwys = import ../home/kotwys;

  system.stateVersion = "21.05";
}
