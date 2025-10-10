{ pkgs, ... }: {
  imports = [ ./tmux.nix ./utilities.nix ./git.nix ];
  home.packages = [ pkgs.zsh-powerlevel10k ];

  home.file = { ".zshrc".source = ../../zsh/.zshrc; };
}
