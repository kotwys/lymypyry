{ lib, stdenv, fetchurl, rpmextract, autoreconfHook, file, libjpeg, cups }:

stdenv.mkDerivation rec {
  pname = "epson-201401w";
  version = "1.0.0";

  src = fetchurl {
    url = "https://download3.ebz.epson.net/dsc/f/03/00/03/45/41/92e9c9254f0ee4230a069545ba27ec2858a2c457/epson-inkjet-printer-201401w-${version}-1lsb3.2.src.rpm";
    sha256 = "0c60m1sd59s4sda38dc5nniwa7dh1b0kv1maajr0x9d38gqlyk3x";
  };

  nativeBuildInputs = [ rpmextract autoreconfHook file ];

  buildInputs = [ libjpeg cups ];

  unpackPhase = ''
    rpmextract $src
    tar -zxf epson-inkjet-printer-201401w-${version}.tar.gz
    tar -zxf epson-inkjet-printer-filter-${version}.tar.gz
    for ppd in epson-inkjet-printer-201401w-${version}/ppds/*; do
      substituteInPlace $ppd --replace "/opt/epson-inkjet-printer-201401w" "$out"
      substituteInPlace $ppd --replace "/cups/lib" "/lib/cups"
    done
    cd epson-inkjet-printer-filter-${version}
  '';

  preConfigure = ''
    chmod +x configure
    export LDFLAGS="$LDFLAGS -Wl,--no-as-needed"
  '';

  postInstall = ''
    cd ../epson-inkjet-printer-201401w-${version}
    cp -a lib64 resource watermark $out
    mkdir -p $out/share/cups/model/epson-inkjet-printer-201401w
    cp -a ppds $out/share/cups/model/epson-inkjet-printer-201401w/
    cp -a Manual.txt $out/doc/
    cp -a README $out/doc/README.driver
  '';

  meta = with lib; {
    homepage = "https://www.openprinting.org/driver/epson-201401w";
    description =
      "Epson printer driver (L456, L455, L366, L365, L362, L360, L312, L310, L222, L220, L132, L130)";
    longDescription = ''
      This software is a filter program used with the Common UNIX Printing
      System (CUPS) under Linux. It supplies high quality printing with
      Seiko Epson Color Ink Jet Printers.

      List of printers supported by this package:
        Epson L456 Series
        Epson L455 Series
        Epson L366 Series
        Epson L365 Series
        Epson L362 Series
        Epson L360 Series
        Epson L312 Series
        Epson L310 Series
        Epson L222 Series
        Epson L220 Series
        Epson L132 Series
        Epson L130 Series

      To use the driver adjust your configuration.nix file:
        services.printing = {
          enable = true;
          drivers = [ pkgs.epson_201401w ];
        };
    '';
    license = with licenses; [ lgpl21 epson ];
    platforms = platforms.linux;
  };
}
