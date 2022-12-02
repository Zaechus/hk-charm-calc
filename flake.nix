{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { nixpkgs, rust-overlay, ... }:
    let system = "x86_64-linux"; in {
      devShell.${system} = let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ rust-overlay.overlays.default ];
        };
      in ({ pkgs, ... }: pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          (rust-bin.fromRustupToolchainFile ./rust-toolchain.toml)
        ];
      }) { inherit pkgs; };
    };
}
