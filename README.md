# DA Build Orb

Copyright (c) 2025 Digital Asset (Switzerland) GmbH and/or its affiliates. All Rights Reserved.
SPDX-License-Identifier: Apache-2.0

CircleCI orb for common build logic used across the repositories of Digital Asset.

This CircleCI orb is only intended for use within Digital Asset and is not likely to be useful for developers outside of DA.

## Usage

Before getting started, make sure you have `nix` installed on your local machine.

1. Create a `flake.nix` in the root of your repository (`nix flake init`).

1. Update your CircleCI file: add a reference to this orb, and add a `nix` step ahead of the rest of the steps of your build.

   ```yaml
   version: 2.1
   orbs:
     da-build: digital-asset/build@1.0.0
   ...
   jobs:
     ...
       steps:
         - checkout

         # this line sets up CircleCI to use nix, and updates your runner to use nix
         - da-build/nix

         # from this point on, normal CircleCI `run` commands use nix!
         - run:
             name: "Do a thing"
             command: |
               cat some-file-in-my-repo.json | jq .awesome
   ...
   ```

## Requirements

This orb assumes that you are in one of the GitHub Digital Asset organizations (`digital-asset` or `DACH-NY`).

## Support

This orb is _unsupported_ for usage outside of Digital Asset.
