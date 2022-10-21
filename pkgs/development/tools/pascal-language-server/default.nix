{ stdenv, lib, fetchFromGitHub, lazarus, fpc }:

stdenv.mkDerivation {
  pname = "pascal-language-server";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "arjanadriaanse";
    repo = "pascal-language-server";
    rev = "f7ff5da753d4b29056c714bfeeefe88328bb66d3";
    sha256 = "1cbq5168dl5843z0i9bznb4xhic7lf15vlhbq6w7ffjqk6ajg5w2";
  };

  nativeBuildInputs = [ lazarus fpc ];

  buildPhase = ''
    HOME=$(mktemp -d) lazbuild \
      --lazarusdir=${lazarus}/share/lazarus \
      --build-mode=Release \
      pasls.lpi
  '';

  doCheck = false;

  installPhase = ''
    mkdir -p $out/bin
    cp lib/x86_64-linux/pasls $out/bin/
  '';

  meta = with lib; {
    description = "LSP server implementation for Pascal";
    homepage = "https://github.com/arjanadriaanse/pascal-language-server";
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
