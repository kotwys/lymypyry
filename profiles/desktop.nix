{ pkgs, config, ... }:

{
  networking.networkmanager.enable = true;
  boot.supportedFilesystems = [ "ntfs" ];

  i18n.defaultLocale = "ru_RU.UTF-8";
  time.timeZone = "Europe/Samara";
  console = {
    font = "latarcyrheb-sun16";
    useXkbConfig = true;
  };

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us,ru";
      options = "grp:alt_shift_toggle,ctrl:swapcaps";
    };
  };

  programs.kdeconnect.enable = true;

  # Allow tunnelling all traffic to Wireguard
  networking.firewall.checkReversePath = "loose";
  networking.hosts = {
    # Please support Ukraine
    "::1" = [ "redirectrussia.org" ];
  };

  services.openssh = {
    enable = true;
    openFirewall = false;
  };

  virtualisation.docker.enable = true;

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
  programs.zsh.enable = true;
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
    };
    packages = with pkgs; [
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
    wget
    git
    helix
  ];

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
    enableSSHSupport = true;
  };

  users.users.kotwys = {
    createHome = true;
    isNormalUser = true;
    extraGroups = [ "wheel" "adbusers" "vboxusers" ];
    shell = pkgs.zsh;
    password = "welcome";
    description = ({
      "ja_JP.UTF-8" = "美瑰郎";
    })."${config.i18n.defaultLocale}" or "Mikajlo";
  };

  home-manager.users.kotwys = import ../home/kotwys;

  system.stateVersion = "21.05";
}
