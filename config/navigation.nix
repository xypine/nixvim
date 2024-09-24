{
  plugins.hop = {
    enable = true;
  };
  keymaps = [
    {
      key = "<leader>hh";
      action = "<CMD>HopNode<CR>";
      options = {
        desc = "Hop";
      };
    }
    {
      key = "<leader>hw";
      action = "<CMD>HopWord<CR>";
      options = {
        desc = "Hop Word";
      };
    }
    {
      key = "f";
      action.__raw = ''
        function()
          require'hop'.hint_char1({
            direction = require'hop.hint'.HintDirection.AFTER_CURSOR,
            current_line_only = true
          })
        end
      '';
      options.remap = true;
    }
    {
      key = "F";
      action.__raw = ''
        function()
          require'hop'.hint_char1({
            direction = require'hop.hint'.HintDirection.BEFORE_CURSOR,
            current_line_only = true
          })
        end
      '';
      options.remap = true;
    }
    {
      key = "t";
      action.__raw = ''
        function()
          require'hop'.hint_char1({
            direction = require'hop.hint'.HintDirection.AFTER_CURSOR,
            current_line_only = true,
            hint_offset = -1
          })
        end
      '';
      options.remap = true;
    }
    {
      key = "T";
      action.__raw = ''
        function()
          require'hop'.hint_char1({
            direction = require'hop.hint'.HintDirection.BEFORE_CURSOR,
            current_line_only = true,
            hint_offset = 1
          })
        end
      '';
      options.remap = true;
    }
  ];
}
