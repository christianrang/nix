{ pkgs, ... }: {
  home.packages = with pkgs; [ git ];

  home.file = { ".gitconfig".source = ../../../git/.gitconfig; };
}
