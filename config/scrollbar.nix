{
  # extraPlugins = with pkgs.vimPlugins; [
  #   minimap-vim
  # ];
  # extraConfigLuaPre = ''
  #   vim.cmd("let g:minimap_width = 10")
  #   vim.cmd("let g:minimap_auto_start = 1")
  #   vim.cmd("let g:minimap_auto_start_win_enter = 1")
  # '';
  plugins.scrollview = {
    enable = true;
  };
}
