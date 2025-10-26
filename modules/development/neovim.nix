{ pkgs, ... }: {
  home.file = {
    ".config/nvim/" = {
      enable = true;
      source = ../../nvim/.config/nvim;
      recursive = true;
    };
  };

  home.packages = with pkgs; [ neovim-remote ];

  programs.neovim.enable = true;

  home.sessionVariables = { EDITOR = "nvr -s"; };
}
