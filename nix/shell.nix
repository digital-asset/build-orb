{ pkgs, ci }:
let
  requiredPackages =
    with pkgs;
    (
      [
        # these packages are required both in CI and for local development

        # we include the Daml SDK merely as a test case for whether fetches
        # from private repositories are working in CircleCI. This repo does
        # not otherwise depend on this component.
        daml-sdk

        mdformat
        nixfmt-rfc-style
        shfmt
        treefmt
        yamlfmt
        yamllint
      ]
      ++ (
        if ci then
          [
            # these packages should only be installed on CI

          ]
        else
          [
            # these packages are only installed on developer machines locally
            circleci-cli
          ]
      )
    );

in
pkgs.mkShell {
  packages = requiredPackages;
}
