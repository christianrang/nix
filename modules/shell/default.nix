{ pkgs, ... }: {
  imports = [ ./tmux.nix ./utilities.nix ./git.nix ./personal-scripts ];
  home.packages = with pkgs; [ 
        zsh-powerlevel10k 
        pass
    ];

  home.file = { ".zshrc".source = ../../zsh/.zshrc; };
}
