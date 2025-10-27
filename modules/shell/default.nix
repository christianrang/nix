{ pkgs, ... }: {
  imports = [ ./tmux.nix ./utilities.nix ./git.nix ./personal-scripts ];
  home.packages = [ pkgs.zsh-powerlevel10k ];

  home.file = { ".zshrc".source = ../../zsh/.zshrc; };
}
