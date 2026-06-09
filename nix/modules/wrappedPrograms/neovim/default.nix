{ inputs, self, lib, ... }: {
  flake.modules.neovim = { pkgs, config, ... }: {
    options = {
      enable = lib.mkEnableOption "neovim";

      languages = {
        lua = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Install Lua language server and formatter";
        };
        python = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Install Python debugger";
        };
      };
    };

    config = {
      home.packages = with pkgs;
        [ postgresql neovim ripgrep ]
        ++ lib.optionals config.languages.lua [ lua-language-server stylua ]
        ++ lib.optionals config.languages.python
        [ (python313.withPackages (python-pkgs: [ python-pkgs.debugpy ])) ];

      home.file = {
        ".config/nvim/" = {
          enable = true;
          source = ./.config/nvim;
          recursive = true;
        };
      };

      home.sessionVariables = { EDITOR = "nvim"; };
    };
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
