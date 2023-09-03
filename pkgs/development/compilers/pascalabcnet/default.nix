{ stdenv, lib, makeWrapper, fetchzip, mono, unar }:

let
  # Able to handle non-standard encoding in filenames
  fetchzip' = args: (fetchzip args).overrideAttrs(old: {
    nativeBuildInputs = old.nativeBuildInputs ++ [ unar ];
    postFetch = ''
      unpackCmdHooks+=(unarUnpack)
      unarUnpack() {
        unar -D -nr "$1"
      }
    '' + old.postFetch;
  });
in
stdenv.mkDerivation {
  pname = "pascalabcnet";
  version = "3.9.0";
  
  src = fetchzip' {
    url = "http://web.archive.org/web/20230822161611/https://pascalabc.net/downloads/PABCNETC.zip";
    sha256 = "0yh16v0jigypkcbbq5j185pysr5fw6wz1c3d5db75mmrvyl2my2s";
    stripRoot = false;
  };
  
  buildInputs = [ makeWrapper ];
  nativeBuildInputs = [ mono ];
  
  installPhase = ''
    mkdir -p "$out/bin"
    mkdir -p "$out/lib/$pname"
    cp -r $src/* "$out/lib/$pname"

    for exe in pabcnetc pabcnetcclear; do
      makeWrapper ${mono}/bin/mono $out/bin/$exe \
        --add-flags "$out/lib/$pname/$exe.exe"
      chmod +x "$out/bin/$exe"
    done
  '';
  
  meta = with lib; {
    homepage = "http://pascalabc.net/en/";
    description = "The new generation Pascal programming language for .NET";
    license = [ licenses.lgpl3 ];
    platforms = platforms.all;
  };
}
