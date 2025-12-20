{ pkgs, lib, ... }:

let
  ref = "2f46d349e3f7e370fcc81e4750238296fb8febed";
  base = "https://github.com/Flowseal/zapret-discord-youtube/raw/${ref}";
  whitelist = pkgs.fetchurl {
    url = "${base}/lists/list-general.txt";
    hash = "sha256-X3hPZdkSllCYdztrImSeXcPy+f6TfFAcbSpC07qsj44=";
  };
  tlsClienthello = pkgs.fetchurl {
    url = "${base}/tls_clienthello_4pda_to.bin";
    hash = "sha256-7v6vCd3o1psfF2ISVB9jxosxSjOjNeztmaiinxclTag=";
  };

  qnum = toString 200;

  params = [
    "--qnum=${qnum}"

    # WebRTC calls
    "--filter-udp=19294-19344,50000-50100"
    "--filter-l7=discord,stun"
    "--dpi-desync=fake"
    "--dpi-desync-repeats=6"

    "--new" # HTTP(s)
    "--filter-tcp=80,443"
    "--hostlist=${whitelist}"
    "--dpi-desync=multisplit"
    "--dpi-desync-split-seqovl=568"
    "--dpi-desync-split-pos=1"
    "--dpi-desync-split-seqovl-pattern=${tlsClienthello}"
  ];
in
{
  systemd.services.zapret = {
    description = "DPI bypass service";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.zapret}/bin/nfqws ${lib.concatStringsSep " " params}";
      Type = "simple";
      PIDFile = "/run/nfqws.pid";
      Restart = "always";
      RuntimeMaxSec = "1h";
    };
  };

  networking.firewall.extraCommands = ''
    ip46tables -t mangle -I POSTROUTING -p udp \
        -m multiport --dports 19294:19344,50000:50100 \
        -m connbytes --connbytes 1:6 --connbytes-mode packets --connbytes-dir original \
        -m mark ! --mark 0x40000000/0x40000000 \
        -j NFQUEUE --queue-num ${qnum} --queue-bypass
    ip46tables -t mangle -I POSTROUTING -p tcp \
      -m tcp --dport 80 \
      -m mark ! --mark 0x40000000/0x40000000 \
      -j NFQUEUE --queue-num ${qnum} --queue-bypass
    ip46tables -t mangle -I POSTROUTING -p tcp \
      -m tcp --dport 443 \
      -m connbytes --connbytes 1:6 --connbytes-mode packets --connbytes-dir original \
      -m mark ! --mark 0x40000000/0x40000000 \
      -j NFQUEUE --queue-num ${qnum} --queue-bypass
  '';
}
