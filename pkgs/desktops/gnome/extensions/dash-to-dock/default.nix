{ lib, stdenv, fetchFromGitHub, glib, gettext, sassc }:

stdenv.mkDerivation {
  pname = "gnome-shell-dash-to-dock";
  version = "69";

  src = fetchFromGitHub {
    owner = "ewlsh";
    repo = "dash-to-dock";
    rev = "f1db97e1d3a8574762794d48bc480bbf8cbde27f";
    sha256 = "1p56xs19xs9khlz2nkf9bnimajywzygscg3j89g4xxjb25rv653q";
  };

  nativeBuildInputs = [ glib gettext sassc ];

  makeFlags = [
    "INSTALLBASE=${placeholder "out"}/share/gnome-shell/extensions"
  ];

  uuid = "dash-to-dock@micxgx.gmail.com";

  meta = with lib; {
    description = "A dock for the Gnome Shell";
    homepage = "micheleg.github.io/dash-to-dock/";
    license = licenses.gpl2;
  };
}
