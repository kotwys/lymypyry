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
  version = "3.8.3";
  
  src = fetchzip' {
    url = "http://web.archive.org/web/20230205091447/http://pascalabc.net/downloads/PABCNETC.zip";
    sha256 = "8l6BRXqkXwYzYhfaJHBu7dSGhsR4QeQ7XAeV9JP9VKQ=";
    stripRoot = false;
  };
  
  buildInputs = [ makeWrapper ];
  nativeBuildInputs = [ mono ];
  
  installPhase = ''
    mkdir -p "$out/bin"
    mkdir -p "$out/lib/$pname"
    cp -r $src/* "$out/lib/$pname"

    for exe in pabcnetc pabcnetcclear; do
      cat >> "$out/bin/$exe" <<EOF
#!/bin/sh
"${mono}/bin/mono" "$out/lib/$pname/$exe.exe" "\$@"
EOF
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
