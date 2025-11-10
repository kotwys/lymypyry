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

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.power-profiles-daemon.enable = true;

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

  programs.nix-ld = {
    enable = true;
    libraries = builtins.attrValues {
      inherit (pkgs)
        zlib zstd curl openssl attr libssh bzip2 libxml2 acl libsodium util-linux
        xz systemd portaudio libGL glib;
      inherit (pkgs.stdenv.cc) cc;
    };
  };

  fonts = {
    fontconfig = {
      enable = true;
      hinting.autohint = true;
      defaultFonts = {
        sansSerif = [ "Noto Sans" "DejaVu Sans" "Noto Color Emoji" ];
        serif = [ "Noto Serif" "DejaVu Serif" "Noto Color Emoji" ];
        monospace = [ "DejaVu Mono" "Noto Color Emoji" ];
      };
    };
    packages = with pkgs; [
      corefonts
      open-sans
      ubuntu_font_family
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk-sans
      source-han-sans
      source-han-serif
      ibm-plex
      plemoljp
    ];
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
    firefox
    vlc
    wget
    git
    vim
    file
  ];

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
    enableSSHSupport = true;
  };

  users.users.kotwys = {
    createHome = true;
    isNormalUser = true;
    extraGroups = [ "wheel" "adbusers" "vboxusers" "docker" ];
    shell = pkgs.zsh;
    password = "welcome";
    description = ({
      "ja_JP.UTF-8" = "美瑰郎";
    })."${config.i18n.defaultLocale}" or "Mikajlo";
  };

  home-manager.users.kotwys = import ../home/kotwys;

  system.stateVersion = "21.05";
}
