{ stdenv, lib }:

stdenv.mkDerivation {
  pname = "hp-laser-10x-driver";
  version = "1.00.39.12";

  src = ./uld-hp;

  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    mkdir -p $out/lib/cups/filter
    mkdir -p $out/share/cups/model

    install -m755 uld/x86_64/rastertospl \
      $out/lib/cups/filter/rastertospl

    install -m644 uld/noarch/share/ppd/HP_Laser_10x_Series.ppd \
      $out/share/cups/model/HP_Laser_10x_Series.ppd
  '';

  meta = {
    description = "HP Laser 10x series CUPS driver";
    platforms = [ "x86_64-linux" ];
  };
}
