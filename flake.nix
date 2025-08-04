{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    { nixvim, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem =
        { pkgs, system, ... }:
        let
          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};
          nixvimModule = {
            inherit pkgs;
            module = import ./config; # import the module directly
            # You can use `extraSpecialArgs` to pass additional arguments to your module files
            extraSpecialArgs = {
              # inherit (inputs) foo;
            };
          };
          nvim = nixvim'.makeNixvimWithModule nixvimModule;
          dockerImage = pkgs.dockerTools.buildImage {
            name = "nixvim";
            tag = "latest";

            copyToRoot = pkgs.buildEnv {
              name = "nvim-env";
              paths = with pkgs; [
                # The main package
                nvim
                # C compiler for treesitter
                zig
                # various basic utils
                bashInteractive
                uutils-coreutils-noprefix
                git
                gnugrep
                gnused
                gawk
                findutils
                which
                curl
                cacert
                less
                gnutar
                gzip
                # some additional niceties
                ripgrep
                fd
              ];
            };
            runAsRoot = ''
              #!${pkgs.runtimeShell}
              mkdir -p /tmp
              chmod 1777 /tmp

              mkdir -p /home/nvim/.local/share/nvim
              mkdir -p /home/nvim/.local/state/nvim
              mkdir -p /home/nvim/.cache/nvim
              mkdir -p /home/nvim/.config/nvim

              # Make everything in /home/nvim writable
              chmod -R 777 /home/nvim
            '';
            config = {
              Cmd = [ "nvim" ]; # Set the default command for the container
              Env = [
                "SHELL=/bin/bash"
                "PATH=/bin:/usr/bin"
                "HOME=/home/nvim"
                "XDG_DATA_HOME=/home/nvim/.local/share"
                "XDG_STATE_HOME=/home/nvim/.local/state"
                "XDG_CACHE_HOME=/home/nvim/.cache"
                "XDG_CONFIG_HOME=/home/nvim/.config"
                "SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
                "NIX_SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
              ];
              WorkingDir = "/home/nvim";
            };
          };
        in
        {
          checks = {
            # Run `nix flake check .` to verify that your config is not broken
            default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
          };

          packages = {
            # Lets you run `nix run .` to start nixvim
            default = nvim;
            dockerImage = dockerImage;
          };
        };
    };
}
