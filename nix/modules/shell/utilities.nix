{ pkgs, ... }: 
{
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
    jless
    tealdeer
 ] ++ (lib.optionals (pkgs.stdenv.isLinux) [
    kubernetes
 ]);
}
