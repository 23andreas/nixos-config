{
  description = "Rust development environment with formatting tools";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      rust-overlay,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };

        rust-toolchain = pkgs.rust-bin.stable.latest.default.override {
          extensions = [
            "rust-src"
            "rust-analyzer"
          ];
          targets = [ "x86_64-unknown-linux-gnu" ];
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # Rust toolchain
            rust-toolchain

            # Formatting and linting tools
            rustfmt
            clippy

            # Additional development tools
            cargo-watch
            cargo-edit
            cargo-audit
            cargo-outdated

            # System dependencies commonly needed
            pkg-config
            openssl

            # Optional: database tools if needed
            # sqlite
            # postgresql
          ];

          shellHook = ''
            echo "🦀 Rust development environment loaded"
            echo "Available tools:"
            echo "  - rustc $(rustc --version)"
            echo "  - cargo $(cargo --version)"
            echo "  - rustfmt for code formatting"
            echo "  - clippy for linting"
            echo "  - cargo-watch for file watching"
            echo ""
            echo "Quick commands:"
            echo "  - cargo fmt          # Format code"
            echo "  - cargo clippy       # Run linter"
            echo "  - cargo watch -x run # Watch and run on changes"
          '';

          RUST_BACKTRACE = 1;
        };
      }
    );
}
