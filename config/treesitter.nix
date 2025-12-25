{
  pkgs,
  ...
}:

{
  plugins.treesitter = {
    enable = true;
    highlight.enable = true;
    indent.enable = true;
  };

  plugins.ts-autotag = {
    enable = true;
  };

  plugins.ts-comments = {
    enable = true;
  };

  plugins.nvim-autopairs = {
    enable = true;
  };
}
