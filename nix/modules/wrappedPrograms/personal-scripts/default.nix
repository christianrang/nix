{ inputs, self, ... }: {
  flake.modules.personal-scripts = { pkgs, ... }: {
    home.packages = with pkgs; [
        fd
    ];
    home.file = {
      ".bin/gclone".source = ./scripts/gclone;
      ".bin/tmux-sessionizer".source = ./scripts/tmux-sessionizer;
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
