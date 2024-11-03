{
  # Import all your configuration modules here
  imports = [ 
    ./bufferline.nix
    ./treesitter.nix 
    ./alpha.nix 
    ./colorscheme.nix
    ./todo.nix
    ./lsp.nix
    ./telescope.nix
    ./which-key.nix 
    ./nvim-cmp.nix 
    ./format.nix 
    ./git.nix 
    ./ai.nix 
    ./http.nix 
    ./candy.nix 
    ./indent.nix 
    ./oil.nix 
    ./presence.nix 
    ./markdown.nix 
    ./trouble.nix 
    ./testaustime.nix 
    ./undo.nix 
    ./navigation.nix 
    ./hex.nix 
  ];
  globals = {
    mapleader = " ";
    maplocalheader = " ";
    have_nerd_font = true;
  };
  opts = {
    number = true;
    mouse = "a";

    updatetime = 250;
    timeoutlen = 300;

    hlsearch = true;
  };
  keymaps = [
    {
      key = "<Esc>";
      mode = "n";
      action = "<cmd>nohlsearch<CR>";
    }
  ];
  performance = {
    byteCompileLua.enable = true;
  };
}
