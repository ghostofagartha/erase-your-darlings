{ lib
, stdenv
, autoPatchelfHook
, cups
}:

stdenv.mkDerivation {
  pname = "hp-laser-10x-driver";
  version = "1.00.39.12";

  src = ./uld-hp;

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    cups
  ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/lib/cups/filter
    mkdir -p $out/share/cups/model

    # HP SPL raster filter
    install -m755 \
      uld/x86_64/rastertospl \
      $out/lib/cups/filter/rastertospl

    # HP printer PPD
    install -m644 \
      uld/noarch/share/ppd/HP_Laser_10x_Series.ppd \
      $out/share/cups/model/HP_Laser_10x_Series.ppd

    # Make the old HP PPD compatible with modern CUPS
    sed -i '/^\*cupsFilter:/d' \
      $out/share/cups/model/HP_Laser_10x_Series.ppd

    echo '*cupsFilter2: "application/vnd.cups-raster application/vnd.cups-raster 0 rastertospl"' \
      >> $out/share/cups/model/HP_Laser_10x_Series.ppd
  '';

  meta = {
    description = "HP Laser 103/107/108 Linux driver";
    homepage = "https://support.hp.com";
    license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
  };
}
