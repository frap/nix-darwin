{
  description = "Gases MacOS system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }: {
    darwinConfigurations = {
      "CiscoKid" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin"; 
        modules = [
          # include the darwin module
          ./darwin.nix
         ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}
