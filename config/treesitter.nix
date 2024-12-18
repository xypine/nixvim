{
  plugins.treesitter = {
    enable = true;
    settings = {
      auto_install = true;
      highlight.enable = true;
      incremental_selection.enable = true;

      # The following are required for Noice.nvim to work
      ensure_installed = [
        "vim"
        "regex"
        "lua"
        "bash"
        "markdown"
        "markdown_inline"
      ];
    };
  };
}
