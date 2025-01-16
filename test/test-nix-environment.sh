#!/usr/bin/env bash
set -x

# basic sanity checks for the nix environment
[[ "$(which nixfmt)" == /nix/store/* ]]
[[ $(nixfmt --version) == 'nixfmt nixpkgs-unstable-2024-08-16' ]]

# verify that the Daml SDK can be loaded
# (we're just testing something that requires a proper netrc configuration)
[[ "$(which daml)" == /nix/store/* ]]
[[ $(daml version) == *3.2.0-snapshot.20241031.13398.0.vf95d2607* ]]
