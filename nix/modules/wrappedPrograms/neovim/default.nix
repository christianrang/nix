{ inputs, self, ... }: {
  flake.modules.neovim = { pkgs, ... }: {
    programs.neovim.enable = true;

    home.packages = with pkgs; [
      lua-language-server
      stylua

      (python313.withPackages (python-pkgs: [ python-pkgs.debugpy ]))

      postgresql
    ];

    home.file = {
      ".config/nvim/" = {
        enable = true;
        source = ./.config/nvim;
        recursive = true;
      };
    };

    home.sessionVariables = { EDITOR = "nvim"; };
  };
  perSystem = { pkgs, self', ... }: {
    apps.neovim = {
      type = "app";
      program = "${pkgs.writeShellScript "neovim" ''
        mkdir -p "$HOME/.config"
        ln -sf ${./.config/nvim} "$HOME/.config/nvim"
        exec ${pkgs.lib.getExe pkgs.neovim} "$@"
      ''}";
    };
  };
}
