{ inputs, self, ... }: {
  flake.modules.neovim = { pkgs, ... }: {
    programs.neovim.enable = true;

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
        ln -sf ${../../../nvim/.config/nvim} "$HOME/.config/nvim"
        exec ${pkgs.lib.getExe pkgs.neovim} "$@"
      ''}";
    };
  };
}
