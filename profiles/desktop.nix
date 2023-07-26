{ pkgs, ... }:

{
  networking.networkmanager.enable = true;
  boot.supportedFilesystems = [ "ntfs" ];

  i18n.defaultLocale = "ru_RU.UTF-8";
  time.timeZone = "Europe/Samara";
  console = {
    font = "latarcyrheb-sun16";
    useXkbConfig = true;
  };
  i18n.inputMethod.enabled = "ibus";
  i18n.inputMethod.ibus.engines = with pkgs.ibus-engines; [ mozc ];

  services.xserver = {
    enable = true;
    layout = "us,ru";
    xkbOptions = "grp:alt_shift_toggle,ctrl:swapcaps";
  };

  services.kdeconnect.enable = true;

  # Allow tunnelling all traffic to Wireguard
  networking.firewall.checkReversePath = "loose";
  networking.hosts = {
    # Please support Ukraine
    "::1" = [ "redirectrussia.org" ];
  };

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
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.hplip ];
  };

  services.flatpak.enable = true;
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
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
        <fontconfig>
        <match target="pattern">
          <test qual="any" name="family"><string>-apple-system</string></test>
          <edit name="family" mode="prepend" binding="same">
            <string>Ubuntu</string>
          </edit>
        </match>
        <match target="pattern">
          <test qual="any" name="family"><string>Cascadia Code</string></test>
          <edit name="family" mode="append" binding="weak">
            <!-- Math symbols -->
            <string>JetBrains Mono</string>
          </edit>
        </match>
        </fontconfig>
      '';
    };
    fonts = with pkgs; [
      corefonts
      open-sans
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      ubuntu_font_family
      cascadia-code
      jetbrains-mono
    ];
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
    firefox
    vlc
    libreoffice-fresh
    wget
    git
    helix
  ];

  users.users.kotwys = {
    createHome = true;
    isNormalUser = true;
    extraGroups = [ "wheel" "adbusers" ];
    shell = pkgs.fish;
    password = "welcome";
  };

  nixpkgs.config.allowUnfree = true;

  home-manager.users.kotwys = import ../home/kotwys;

  system.stateVersion = "21.05";
}
