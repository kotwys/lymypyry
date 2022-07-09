{ stdenv, lib, fetchurl, bash, jdk, libpulseaudio, runCommand, xorg }:

let
  version = "1.114.3";
  librariesPath = with xorg;
    lib.makeLibraryPath [
      libX11
      libXext
      libXcursor
      libXrandr
      libXxf86vm
      libpulseaudio
    ];
in runCommand "tl-${version}" {
  binary = fetchurl {
    url = "https://tlaun.ch/jar";
    sha256 = "0y90g9kkxxwaa9ixzamd74izh3hvw12rwcyd2z7drnmhnal67psj";
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
