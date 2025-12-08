{ pkgs, ... }: {
  home.packages = with pkgs; [  
        pass
        gnupg
    ];
}
