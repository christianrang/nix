{ pkgs, ... }: {
  imports = [ ./tmux.nix ./utilities.nix ./git.nix ./personal-scripts ./pass.nix];
  home.packages = with pkgs; [ 
        zsh-powerlevel10k 
    ];

  home.file = { ".zshrc".source = ../../../zsh/.zshrc; };
}
