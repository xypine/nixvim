{
  plugins = {
    gitsigns = {
      enable = true;
    };
    gitblame = {
      enable = true;
    };
    fugitive = {
      enable = true;
    };
  };

  # Git hunk navigation
  keymaps = [
    {
      mode = "n";
      key = "]c";
      action = "<cmd>Gitsigns next_hunk<cr>";
      options = {
        desc = "Next git hunk";
      };
    }
    {
      mode = "n";
      key = "[c";
      action = "<cmd>Gitsigns prev_hunk<cr>";
      options = {
        desc = "Previous git hunk";
      };
    }
  ];
}
