{ pkgs, ... }: {
  home.file = {
    ".config/nvim/" = {
      enable = true;
      source = ../../../nvim/.config/nvim;
      recursive = true;
    };
  };

  programs.neovim.enable = true;

  home.sessionVariables = { EDITOR = "nvim"; };
}
