{ config, pkgs, inputs, ... }:

{
  # Dependencies
  #
  # https://nix-community.github.io/nixvim/plugins/cmp-nvim-lsp.html
  # plugins.cmp-nvim-lsp = {
  #   enable = true;
  # };
  plugins.friendly-snippets.enable = true;
  plugins.blink-cmp = {
    enable = true;
    settings = {
      accept = {
        auto_brackets = {
          enabled = true;
        };
      };
      windows.documentation = {
        auto_show = true;
      };
      highlight = {
        use_nvim_cmp_as_default = true;
      };
      keymap = {
        preset = "default";
        "<Tab>" = [
          "select_and_accept"
          "fallback"
        ];
      };
      trigger = {
        signature_help = {
          enabled = true;
        };
      };
    };
  };

  # Useful status updates for LSP.
  plugins.fidget = {
    enable = true;
  };
  # https://nix-community.github.io/nixvim/plugins/noice/index.html
  # plugins.noice = {
  #   enable = true;
  #   settings.lsp.override = {
  #     "vim.lsp.util.convert_input_to_markdown_lines" = true;
  #     "vim.lsp.util.stylize_markdown" = true;
  #     "cmp.entry.get_documentation" = true;
  #   };
  #   settings.presets = {
  #     bottom_search = true;
  #     command_palette = true;
  #     long_message_to_split = true;
  #     inc_rename = false;
  #     lsp_doc_border = false;
  #   };
  # };
  plugins.notify.enable = true;

  plugins.crates.enable = true;

  extraPackages = with pkgs; [
    go
  ];

  # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=extraplugi#extraplugins 
  extraPlugins = with pkgs.vimPlugins; [
    # NOTE: This is how you would ad a vim plugin that is not implemented in Nixvim, also see extraConfigLuaPre below
    # `neodev` configure Lua LSP for your Neovim config, runtime and plugins
    # used for completion, annotations, and signatures of Neovim apis
    neodev-nvim
    # Allow customizing lsp settings per-directory using a .neoconf.json file
    neoconf-nvim
  ];

  # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=extraplugi#extraconfigluapre
  extraConfigLuaPre = ''
    require('neodev').setup {}
    require('neoconf').setup {}
    -- Hotfix for "server cancelled request"
    for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
        local default_diagnostic_handler = vim.lsp.handlers[method]
        vim.lsp.handlers[method] = function(err, result, context, config)
            if err ~= nil and err.code == -32802 then
                return
            end
            return default_diagnostic_handler(err, result, context, config)
        end
    end
  '';

  # https://nix-community.github.io/nixvim/NeovimOptions/autoGroups/index.html
  autoGroups = {
    "kickstart-lsp-attach" = {
      clear = true;
    };
  };

  # Brief aside: **What is LSP?**
  #
  # LSP is an initialism you've probably heard, but might not understand what it is.
  #
  # LSP stands for Language Server Protocol. It's a protocol that helps editors
  # and language tooling communicate in a standardized fashion.
  #
  # In general, you have a "server" which is some tool built to understand a particular
  # language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
  # (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
  # processes that communicate with some "client" - in this case, Neovim!
  #
  # LSP provides Neovim with features like:
  #  - Go to definition
  #  - Find references
  #  - Autocompletion
  #  - Symbol Search
  #  - and more!
  #
  # Thus, Language Servers are external tools that must be installed separately from
  # Neovim which are configured below in the `server` section.
  #
  # If you're wondering about lsp vs treesitter, you can check out the wonderfully
  # and elegantly composed help section, `:help lsp-vs-treesitter`
  #
  # https://nix-community.github.io/nixvim/plugins/lsp/index.html
  plugins.lsp = {
    enable = true;

    # Enable the following language servers
    #  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    #
    #  Add any additional override configuration in the following tables. Available keys are:
    #  - cmd: Override the default command used to start the server
    #  - filetypes: Override the default list of associated filetypes for the server
    #  - capabilities: Override fields in capabilities. Can be used to disable certain LSP features.
    #  - settings: Override the default settings passed when initializing the server.
    #        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
    servers = {
      clangd = {
        enable = true;
      };
      gopls = {
        enable = true;
      };
      pyright = {
        enable = true;
      };
      rust_analyzer = {
        enable = true;
        installCargo = true;
        installRustc = true;
      };
      # ...etc. See `https://nix-community.github.io/nixvim/plugins/lsp` for a list of pre-configured LSPs
      #
      # Some languages (like typscript) have entire language plugins that can be useful:
      #    `https://nix-community.github.io/nixvim/plugins/typescript-tools/index.html?highlight=typescript-tools#pluginstypescript-toolspackage`
      #
      # But for many setups the LSP (`ts-ls`) will work just fine
      ts_ls = {
        enable = true;
      };
      eslint = {
        enable = true;
      };
      svelte = {
        enable = true;
      };
      nixd = {
        enable = true;
      };
      marksman = {
        enable = true;
      };
      jsonls = {
        enable = true;
      };
      yamlls = {
        enable = true;
      };
      # For .toml files
      taplo = {
        enable = true;
      };

      lua_ls = {
        enable = true;

        # cmd = {
        #};
        # filetypes = {
        #};
        settings = {
          completion = {
            callSnippet = "Replace";
          };
          #diagnostics = {
          #  disable = {
          #    "missing-fields";
          #};
        };
      };

      typos_lsp = {
        enable = true;
      };
    };

    keymaps = {
      # Diagnostic keymaps
      diagnostic = {
        "[d" = {
          #mode = "n";
          action = "goto_prev";
          desc = "Go to previous [D]iagnostic message";
        };
        "]d" = {
          #mode = "n";
          action = "goto_next";
          desc = "Go to next [D]iagnostic message";
        };
        "<leader>e" = {
          #mode = "n";
          action = "open_float";
          desc = "Show diagnostic [E]rror messages";
        };
        "<leader>q" = {
          #mode = "n";
          action = "setloclist";
          desc = "Open diagnostic [Q]uickfix list";
        };
      };

      extra = [
        # Jump to the definition of the word under your cursor.
        #  This is where a variable was first declared, or where a function is defined, etc.
        #  To jump back, press <C-t>.
        {
          mode = "n";
          key = "gd";
          action.__raw = "require('telescope.builtin').lsp_definitions";
          options = {
            desc = "LSP: [G]oto [D]efinition";
          };
        }
        # Find references for the word under your cursor.
        {
          mode = "n";
          key = "gr";
          action.__raw = "require('telescope.builtin').lsp_references";
          options = {
            desc = "LSP: [G]oto [R]eferences";
          };
        }
        # Jump to the implementation of the word under your cursor.
        #  Useful when your language has ways of declaring types without an actual implementation.
        {
          mode = "n";
          key = "gI";
          action.__raw = "require('telescope.builtin').lsp_implementations";
          options = {
            desc = "LSP: [G]oto [I]mplementation";
          };
        }
        # Jump to the type of the word under your cursor.
        #  Useful when you're not sure what type a variable is and you want to see
        #  the definition of its *type*, not where it was *defined*.
        {
          mode = "n";
          key = "<leader>D";
          action.__raw = "require('telescope.builtin').lsp_type_definitions";
          options = {
            desc = "LSP: Type [D]efinition";
          };
        }
        # Fuzzy find all the symbols in your current document.
        #  Symbols are things like variables, functions, types, etc.
        {
          mode = "n";
          key = "<leader>ds";
          action.__raw = "require('telescope.builtin').lsp_document_symbols";
          options = {
            desc = "LSP: [D]ocument [S]ymbols";
          };
        }
        # Fuzzy find all the symbols in your current workspace.
        #  Similar to document symbols, except searches over your entire project.
        {
          mode = "n";
          key = "<leader>ws";
          action.__raw = "require('telescope.builtin').lsp_dynamic_workspace_symbols";
          options = {
            desc = "LSP: [W]orkspace [S]ymbols";
          };
        }
      ];

      lspBuf = {
        # Rename the variable under your cursor.
        #  Most Language Servers support renaming across files, etc.
        "<leader>rn" = {
          #mode = "n"; TODO: FIGURE OUT HOW TO SET THIS
          action = "rename";
          desc = "LSP: [R]e[n]ame";
        };
        # Execute a code action, usually your cursor needs to be on top of an error
        # or a suggestion from your LSP for this to activate.
        "<leader>ca" = {
          #mode = "n";
          action = "code_action";
          desc = "LSP: [C]ode [A]ction";
        };
        # Opens a popup that displays documentation about the word under your cursor
        #  See `:help K` for why this keymap.
        "K" = {
          action = "hover";
          desc = "LSP: Hover Documentation";
        };
        # WARN: This is not Goto Definition, this is Goto Declaration.
        #  For example, in C this would take you to the header.
        "gD" = {
          action = "declaration";
          desc = "LSP: [G]oto [D]eclaration";
        };
      };
    };

    # LSP servers and clients are able to communicate to each other what features they support.
    #  By default, Neovim doesn't support everything that is in the LSP specification.
    #  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    #  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
    # NOTE: This is done automatically by Nixvim when enabling cmp-nvim-lsp below is an example if you did want to add new capabilities
    capabilities = ''
      capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
    '';

    # This function gets run when an LSP attaches to a particular buffer.
    #   That is to say, every time a new file is opened that is associated with
    #   an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
    #   function will be executed to configure the current buffer
    # NOTE: This is an example of an attribute that takes raw lua
    onAttach = ''
      -- NOTE: Remember that Lua is a real programming language, and as such it is possible
      -- to define small helper and utility functions so you don't have to repeat yourself.
      --
      -- In this case, we create a function that lets us more easily define mappings specific
      -- for LSP related items. It sets the mode, buffer and description for us each time.
      local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
      end

      -- The following two autocommands are used to highlight references of the
      -- word under the cursor when your cursor rests there for a little while.
      --    See `:help CursorHold` for information about when this is executed
      --
      -- When you move your cursor, the highlights will be cleared (the second autocommand).
      if client and client.server_capabilities.documentHighlightProvider then
        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = bufnr,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = bufnr,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
          end,
        })
      end

      -- The following autocommand is used to enable inlay hints in your
      -- code, if the language server you are using supports them
      --
      -- This may be unwanted, since they displace some of your code
      if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
        map('<leader>th', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, '[T]oggle Inlay [H]ints')
      end
    '';
  };
}
