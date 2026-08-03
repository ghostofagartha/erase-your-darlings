{ pkgs, ... }:

let
  sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "black_hole";
    themeConfig = {
      HeaderTextColor = "#d5c4a1";
    };
  };
in {
  environment.systemPackages = [
    sddm-astronaut
  ];
  services.displayManager.sddm = {
    enable = true;

    extraPackages = with pkgs; [
      kdePackages.qtmultimedia
    ];
    theme = "sddm-astronaut-theme";
  };
}
