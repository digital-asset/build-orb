{ stdenv, jdk }:
let
  sources = builtins.fromJSON (builtins.readFile ./daml-sources.json);
  os = if stdenv.isDarwin then "macos" else "linux";
  arch = if stdenv.isDarwin then "" else "-intel";
in
stdenv.mkDerivation {
  name = "daml-sdk";
  version = sources.version;
  src = builtins.fetchurl {
    url =
      if sources.source == "private" then
        "https://digitalasset.jfrog.io/artifactory/assembly/daml/${sources.sdk_version}/daml-sdk-${sources.sdk_version}-${os}${arch}.tar.gz"
      else
        "https://github.com/digital-asset/daml/releases/download/v${sources.version}/daml-sdk-${sources.sdk_version}-${os}-x86_64.tar.gz";
    sha256 = if stdenv.isDarwin then sources.macos_sha256 else sources.linux_sha256;
  };
  dontUnpack = true;
  buildPhase = ''
    mkdir daml
    tar xzf $src -C daml --strip-components 1
    patchShebangs .
  '';
  installPhase = ''
    cd daml
    DAML_HOME=$out ./install.sh --install-with-internal-version yes
  '';
  propagatedBuildInputs = [ jdk ];
  preFixup = ''
    # Set DAML_HOME automatically.
    mkdir -p $out/nix-support
    echo export DAML_HOME=$out > $out/nix-support/setup-hook
  '';
}
