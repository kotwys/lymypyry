{ stdenv, lib, makeWrapper, fetchzip, mono }:

stdenv.mkDerivation {
  pname = "pascalabcnet";
  version = "3.8.3";
  
  src = fetchzip {
    url = "http://web.archive.org/web/20220518183739/http://pascalabc.net/downloads/PABCNETC.zip";
    sha256 = "1j7qc3pgyyqhwhwrwqdflzg6xl1l7vd1hw13ni86x9ynv7mmxhfy";
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
