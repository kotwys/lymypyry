{ pkgs, ... }:

{
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

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
    extraXkbOptions = {
      typo.birman = {
        include = [ "typo(base)" ];

        keys.TLDE = [ "NoSymbol" "NoSymbol" "NoSymbol" "dead_grave" ];
        keys.AE06 = [ "NoSymbol" "NoSymbol" "NoSymbol" "dead_circumflex" ];
        keys.AE09 = [ "NoSymbol" "NoSymbol" "NoSymbol" "U2039" ];
        keys.AE10 = [ "NoSymbol" "NoSymbol" "NoSymbol" "U203A" ];

        keys.AD01 = [ "NoSymbol" "NoSymbol" "NoSymbol" "dead_breve" ];
        keys.AD02 = [ "NoSymbol" "NoSymbol" "radical" "NoSymbol" ];
        keys.AD04 = [ "NoSymbol" "NoSymbol" "NoSymbol" "dead_abovering" ];
        keys.AD06 = [ "NoSymbol" "NoSymbol" "U0463" "U0462" ];
        keys.AD07 = [ "NoSymbol" "NoSymbol" "U0475" "U0474" ];
        keys.AD08 = [ "NoSymbol" "NoSymbol" "Ukrainian_i" "Ukrainian_I" ];
        keys.AD09 = [ "NoSymbol" "NoSymbol" "U0473" "U0472" ];

        keys.AC01 = [ "NoSymbol" "NoSymbol" "approxeq" "U2318" ];
        keys.AC03 = [ "NoSymbol" "NoSymbol" "NoSymbol" "U2300" ];
        keys.AC06 = [ "NoSymbol" "NoSymbol" "NoSymbol" "dead_doubleacute" ];
        keys.AC10 = [ "NoSymbol" "NoSymbol" "NoSymbol" "dead_diaeresis" ];

        keys.AB01 = [ "NoSymbol" "NoSymbol" "NoSymbol" "dead_cedilla" ];
        keys.AB04 = [ "NoSymbol" "NoSymbol" "NoSymbol" "dead_caron" ];
        keys.AB06 = [ "NoSymbol" "NoSymbol" "NoSymbol" "dead_tilde" ];
        keys.AB10 = [ "NoSymbol" "NoSymbol" "NoSymbol" "dead_acute" ];
      };
    };
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

  programs.ssh.askPassword = "";

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
