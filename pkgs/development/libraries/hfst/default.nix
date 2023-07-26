{ stdenv, lib, fetchFromGitHub, ncurses, readline, icu, libtool, gettext
, flex, bison, glib, pkg-config, autoreconfHook
, withOpenFST ? true
, withSFST ? true
, withFoma ? true
, enableTools ? [ ]
}:

let
  version = "3.16.0";
  sha256 = "0ifj2rs5gmzc2npdhnnglcgj8m0k1ww53svy9shrywhg9yrz896r";
in
stdenv.mkDerivation {
  pname = "hfst";
  inherit version;

  src = fetchFromGitHub {
    owner = "hfst";
    repo = "hfst";
    rev = "v${version}";
    inherit sha256;
  };

  buildInputs = [
    pkg-config glib flex bison libtool gettext icu autoreconfHook
  ] ++ (lib.optionals withSFST [ ncurses readline ]);

  autoreconfFlags = [ "-fvi" ];

  configureFlags =
    (lib.optionals (!withOpenFST) [ "--without-openfst" ])
    ++ (lib.optionals (!withSFST) [ "--without-sfst" ])
    ++ (lib.optionals (!withFoma) [ "--without-foma" ])
    ++ (map (x: "--enable-${x}") enableTools);

  meta = with lib; {
    description = "Helsinki Finite-State Technology (library and application suite)";
    homepage = "https://hfst.github.io";
    license = licenses.gpl3;
    platforms = [ "x86_64-linux" ];
  };
}
