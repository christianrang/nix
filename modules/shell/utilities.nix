{ pkgs, ... }: {
  home.packages = with pkgs; [
    fd
    gh
    ripgrep
    bat
    fzf
    stow
    rclone
    mods
    gum
    jq
    unzip
    kubernetes
    jless
    tealdeer
  ];
}
