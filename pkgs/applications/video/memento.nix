{ stdenv, lib, fetchFromGitHub
, cmake
, json_c, libzip, mecab, mpv, sqlite
, qtbase, qtsvg, qtx11extras
, wrapQtAppsHook
, ytdlSupport ? false, youtube-dl }:

let
  version = "0.5.5-1-beta";
in stdenv.mkDerivation {
  pname = "memento";
  inherit version;

  src = fetchFromGitHub {
    owner = "ripose-jp";
    repo = "Memento";
    rev = "v${version}";
    sha256 = "1vd665blrmp3bzs3zmjna9ikjkkkl0marai93r196ylcz887368z";
  };

  buildInputs = [
    mpv sqlite mecab json_c libzip
    qtbase qtsvg
  ] ++ lib.optional ytdlSupport youtube-dl
    ++ lib.optionals stdenv.isLinux [ qtx11extras ];

  nativeBuildInputs = [ cmake wrapQtAppsHook ];

  meta = with lib; {
    homepage = "https://ripose-jp.github.io/Memento/";
    description = "An mpv-based video player for studying Japanese";
    license = [ licenses.gpl2 ];
    platforms = platforms.all;
  };
}
