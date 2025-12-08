{ pkgs, ... }:

{
  imports = [ 
        ./zathura 
        ./mac
    ];
  # home.packages = with pkgs; [ spotify ];
}

