{ config, pkgs, ... }:

{
  environment.sessionVariables = {
    QT_QPA_PLATFORM = "xcb";
  };
}
