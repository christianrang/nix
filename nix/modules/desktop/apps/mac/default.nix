{ pkgs, lib, ... }:
let
  isDarwin = pkgs.stdenv.isDarwin;
in {

  home.activation.makeTrampolineApps = lib.mkIf isDarwin (
    lib.hm.dag.entryAfter [ "writeBoundary" ] (
      builtins.readFile ./make-app-trampolines.sh
    )
  );
}
