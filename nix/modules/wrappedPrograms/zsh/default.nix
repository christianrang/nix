{ inputs, self, ... }: {
  flake.modules.zsh = { pkgs, ... }: {
    home.packages = with pkgs; [ zsh zsh-powerlevel10k fzf ];

    home.file = { ".zshrc".source = ./.zshrc; };
  };

  perSystem = { pkgs, ... }: {
    apps.zsh = {
      type = "app";
      program = "${pkgs.writeShellScript "zsh" ''
        ln -sf ${./.zshrc} "$HOME/.zshrc"
        exec ${pkgs.lib.getExe pkgs.zsh} "$@"
      ''}";
    };
  };
}
