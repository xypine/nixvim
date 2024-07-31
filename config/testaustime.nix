{ pkgs, ... }:

{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "testaustime.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "Testaustime";
        repo = "testaustime.nvim";
        rev = "0ac103ee10e32e90272c208e9d1b0c68dc4f5739";
        hash = "sha256-gj1a6y2B3D4icsYRdY+ZxJWJ/2ioIWIGZQuBmd0M+wE=";
      };
    })
  ];
}
