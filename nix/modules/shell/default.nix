{ self, ... }: {
  flake.modules.shell = { pkgs, ... }: {
    home.packages = with pkgs; [ bat jq ];

    imports = [
      self.modules.neovim
      self.modules.personal-scripts
      self.modules.tmux
      self.modules.zsh
      self.modules.git
    ];
  };
}
