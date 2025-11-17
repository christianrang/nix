## Releasing, versioning and tagging

Releases are named YYYY.MM.{NUMBER}{ALPHA}. {NUMBER} should be monotonically increasing based on the release. {ALPHA} will indicate what type of machine the tag was tested on. This might mean many tags for a single commit. The naming convention is below:
- l = linux
- m = mac
- wsl = wsl

It is preferred that each machine type has it's own tag. This makes finding the latest version for your system easiest.
