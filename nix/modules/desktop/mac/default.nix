{ ... }: {
  flake.modules.mac = { pkgs, lib, ... }: lib.mkIf pkgs.stdenv.isDarwin {
    home.packages = [ pkgs.aerospace ];
    home.file.".config/aerospace/" = {
      source = ../../../../aerospace/.config/aerospace;
      recursive = true;
    };
    home.activation.makeTrampolineApps = lib.hm.dag.entryAfter [ "writeBoundary" ]
      (builtins.readFile ./make-app-trampolines.sh);
  };
}
