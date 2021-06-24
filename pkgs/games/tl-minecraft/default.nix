{ stdenv, fetchurl, bash, jdk, libpulseaudio, runCommand, xorg }:

let
  version = "1.114.3";
  librariesPath = with xorg;
    stdenv.lib.makeLibraryPath [
      libX11
      libXext
      libXcursor
      libXrandr
      libXxf86vm
      libpulseaudio
    ];
in runCommand "tl-${version}" {
  binary = fetchurl {
    url = "https://tlaun.ch/latest/jar";
    sha256 = "0k6y1jblgbd2jypfbmxrnbx2k647b72wghfbbnk8qb9gs4k3ji9j";
  };
  PATH = "${stdenv}/bin";
  desktopFile = ./tl.desktop;
  icon = ./minecraft.png;
  runScript = ./run.sh;
} ''
  mkdir -p $out/{bin,share/{applications,tl,pixmaps}}
  cp $binary $out/share/tl/Bootstrap.jar
  cp $icon $out/share/pixmaps/minecraft.png
  substitute $desktopFile $out/share/applications/tl.desktop --subst-var out

  substitute $runScript $out/bin/tl \
    --subst-var out \
    --subst-var-by shell ${bash}/bin/bash \
    --subst-var-by jdk ${jdk} \
    --subst-var-by xrandr ${xorg.xrandr} \
    --subst-var-by libs ${librariesPath}

  chmod +x $out/bin/tl
''
