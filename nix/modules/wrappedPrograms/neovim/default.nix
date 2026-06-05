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
  perSystem = { pkgs, self', ... }: { };
}
