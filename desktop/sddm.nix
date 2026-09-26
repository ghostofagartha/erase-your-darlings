{ pkgs, ... }:

# let
#   sddm-astronaut = pkgs.sddm-astronaut.override {
#     embeddedTheme = "black_hole";
#     themeConfig = {
#       HeaderTextColor = "#d5c4a1";
#     };
#   };
# in {
#   environment.systemPackages = with pkgs; [
#     sddm-astronaut
#     gum
#   ];
  services.displayManager.gdm = {
    enable = true;
    #
    # extraPackages = with pkgs; [
    #   kdePackages.qtmultimedia
    # ];
    # theme = "sddm-astronaut-theme";
  };
}
