{ pkgs, ... }: {
  home.packages = with pkgs;
  # Python and debugging package to work with nvim-dap
    [ (python313.withPackages (python-pkgs: [ python-pkgs.debugpy ])) ];
}
