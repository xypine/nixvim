{ config, pkgs, inputs, ... }:

{
    # Fuzzy Finder (files, lsp, etc)
    # https://nix-community.github.io/nixvim/plugins/telescope/index.html
    plugins.telescope = {
      # Telescope is a fuzzy finder that comes with a lot of different things that
      # it can fuzzy find! It's more than just a "file finder", it can search
      # many different aspects of Neovim, your workspace, LSP, and more!
      #
      # The easiest way to use Telescope, is to start by doing something like:
      #  :Telescope help_tags
      #
      # After running this command, a window will open up and you're able to
      # type in the prompt window. You'll see a list of `help_tags` options and
      # a corresponding preview of the help.
      #
      # Two important keymaps to use while in Telescope are:
      #  - Insert mode: <c-/>
      #  - Normal mode: ?
      #
      # This opens a window that shows you all of the keymaps for the current
      # Telescope picker. This is really useful to discover what Telescope can
      # do as well as how to actually do it!
      #
      # [[ Configure Telescope ]]
      # See `:help telescope` and `:help telescope.setup()`
      enable = true;

      settings = {
        pickers = {
          find_files = {
            hidden = true;
          };
          file_browser = {
            hidden = true;
          };
        };
        defaults.path_display = "shorten";
      };
      

      # Enable Telescope extensions
      extensions = {
        fzf-native.enable = true;
        ui-select.enable = true;
        file-browser.enable = true;
      };

      # You can put your default mappings / updates / etc. in here
      #  See `:help telescope.builtin`
      keymaps = {
        "<leader>ff" = {
          mode = "n";
          action = "find_files";
          options = {
            desc = "[F]ind [F]iles";
          };
        };
        "<leader>fb" = {
          mode = "n";
          action = "file_browser";
          options = {
            desc = "[F]ile [B]rowser";
          };
        };
        "<leader>fg" = {
          mode = "n";
          action = "live_grep";
          options = {
            desc = "[F]ind [G]rep";
          };
        };
        "<leader>fl" = {
          mode = "n";
          action = "buffers";
          options = {
            desc = "[F]ind [B]uffers";
          };
        };
        "<leader>fh" = {
          mode = "n";
          action = "help_tags";
          options = {
            desc = "[F]ind [H]elp";
          };
        };
        "<leader>ss" = {
          mode = "n";
          action = "lsp_document_symbols";
          options = {
            desc = "[S]earch [S]ymbols";
          };
        };
        "<leader>sr" = {
          mode = "n";
          action = "lsp_references";
          options = {
            desc = "[S]earch [R]eferences";
          };
        };
        "<leader>sd" = {
          mode = "n";
          action = "lsp_definitions";
          options = {
            desc = "[S]earch [D]efinitions";
          };
        };
        "<leader>st" = {
          mode = "n";
          action = "lsp_type_definitions";
          options = {
            desc = "[S]earch [T]ype definitions";
          };
        };
        "<leader>si" = {
          mode = "n";
          action = "lsp_implementations";
          options = {
            desc = "[S]earch [I]mplementations";
          };
        };
        "<leader>sT" = {
          mode = "n";
          action = "treesitter";
          options = {
            desc = "[S]earch [T]reesitter";
          };
        };
        "<leader>sk" = {
          mode = "n";
          action = "keymaps";
          options = {
            desc = "[S]earch [K]eymaps";
          };
        };
        "<leader>sS" = {
          mode = "n";
          action = "builtin";
          options = {
            desc = "[S]earch [S]elect Telescope";
          };
        };
        "<leader>sw" = {
          mode = "n";
          action = "grep_string";
          options = {
            desc = "[S]earch current [W]ord";
          };
        };
        "<leader>sD" = {
          mode = "n";
          action = "diagnostics";
          options = {
            desc = "[S]earch [D]iagnostics";
          };
        };
        "<leader>fr" = {
          mode = "n";
          action = "resume";
          options = {
            desc = "[F]ind [R]esume";
          };
        };
        "<leader>so" = {
          mode = "n";
          action = "oldfiles";
          options = {
            desc = "[S]earch Recent Files ('.' for repeat)";
          };
        };
      };
      settings = {
	extensions.__raw = "{ ['ui-select'] = { require('telescope.themes').get_dropdown() } }";
      };
    };

    # https://nix-community.github.io/nixvim/keymaps/index.html
    keymaps = [
      # Slightly advanced example of overriding default behavior and theme
      {
        mode = "n";
	key = "<leader>fb";
	# You can pass additional configuration to Telescope to change the theme, layout, etc.
	action.__raw = ''
	  function()
            vim.cmd([[
              :Telescope file_browser path=%:p:h select_buffer=true<CR>
            ]])
	  end
	'';
	options = {
          desc = "[F]ile [B]rowser";
	};
      }
      {
        mode = "n";
	key = "<leader>s/";
        # It's also possible to pass additional configuration options.
        #  See `:help telescope.builtin.live_grep()` for information about particular keys
	action.__raw = ''
	  function()
	    require('telescope.builtin').live_grep {
	      grep_open_files = true,
	      prompt_title = 'Live Grep in Open Files'
	    }
	  end
	'';
        options = {
          desc = "[S]earch [/] in Open Files";
        };
      }
    ];
}
