{ config, pkgs, inputs, ... }:

{
  plugins.conform-nvim = {
    enable = true;
    settings = {
      format_on_save = {
        lspFallback = true;
        timeoutMs = 500;
      };
      notifyOnError = true;
      formattersByFt = {
        html = [ [ "prettierd" "prettier" ] ];
        css = [ [ "prettierd" "prettier" ] ];
        javascript = [ [ "prettierd" "prettier" ] ];
        javascriptreact = [ [ "prettierd" "prettier" ] ];
        typescript = [ [ "prettierd" "prettier" ] ];
        typescriptreact = [ [ "prettierd" "prettier" ] ];
        python = [ "black" ];
        lua = [ "stylua" ];
        nix = [ "nixpkgs-fmt" ];
        rust = [ "rustfmt" ];
        markdown = [ [ "prettierd" "prettier" ] ];
        yaml = [ "yamllint" "yamlfmt" ];
      };
    };
  };
  extraPackages = with pkgs; [ black pylint prettierd stylua nixpkgs-fmt yamllint yamlfmt rustfmt ];
}
