{ pkgs, ... }: {
  home.file = { 
        ".bin/gclone".source = ./gclone;
        ".bin/tmux-sessionizer".source = ./tmux-sessionizer;
    };
}
