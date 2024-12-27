{
  plugins.undotree.enable = true;
  keymaps = [
    {
      key = "<leader><F5>";
      action = "<cmd>UndotreeToggle<cr>";
      options = {
        desc = "Toggle Undo Tree";
      };
    }
  ];
}
