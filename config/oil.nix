{
  plugins.oil.enable = true;
  keymaps = [
    {
      key = "-";
      mode = "n";
      action = "<CMD>Oil<CR>";
      options = {
        desc = "Open Oil";
      };
    }
  ];
}
