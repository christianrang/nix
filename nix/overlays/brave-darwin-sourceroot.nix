# The darwin Brave package unpacks Brave-Browser-arm64.dmg with undmg but never
# sets sourceRoot, so stdenv has to guess the source directory. The DMG ships a
# drag-to-install symlink to /Applications named " " (a single space) alongside
# "Brave Browser.app"; stdenv's detection loop globs it and `[ -d ]` follows the
# symlink, so it sees two directories and aborts with:
#
#   unpacker produced multiple directories
#
# Pinning sourceRoot skips the guessing entirely. Upstream nixpkgs still has no
# sourceRoot here as of the current pin, so this cannot be fixed by a bump.
final: prev:
prev.lib.optionalAttrs prev.stdenv.hostPlatform.isDarwin {
  brave = prev.brave.overrideAttrs (_: { sourceRoot = "Brave Browser.app"; });
}
