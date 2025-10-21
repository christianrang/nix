{ lib, config, pkgs, ... }:

{
  imports = [ ./zathura ];
  home.packages = with pkgs; [ spotify ];
}

