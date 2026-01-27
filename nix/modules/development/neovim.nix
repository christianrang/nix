{ pkgs, ... }: {

  home.packages = with pkgs; [ ast-grep neovim ];

  home.file = {
    ".config/nvim/" = {
      enable = true;
      source = ../../../nvim/.config/nvim;
      recursive = true;
    };
  };

  home.sessionVariables = { EDITOR = "nvim"; };
}
