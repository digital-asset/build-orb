[
  (self: super: {
    daml-sdk = super.callPackage ./daml-sdk.nix {
      inherit (self) stdenv;
      jdk = self.openjdk17;
    };
  })
]
