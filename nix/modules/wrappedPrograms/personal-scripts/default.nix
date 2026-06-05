{ inputs, self, ... }: {
  flake.modules.personal-scripts = { pkgs, ... }: {
    home.file = {
      ".bin/gclone".source = ./gclone;
      ".bin/tmux-sessionizer".source = ./tmux-sessionizer;
    };
  };

  perSystem = { pkgs, ... }: {
    apps.personal-scripts = {
      type = "app";
      program = "${pkgs.writeShellScript "zsh" ''
        mkdir -p ~/.bin
        ln -sf ${./scripts} "$HOME/.bin"
      ''}";
    };
  };
}
