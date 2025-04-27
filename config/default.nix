{
  # Import all your configuration modules here
  imports = [
    ./treesitter.nix
    ./alpha.nix
    ./colorscheme.nix
    ./todo.nix
    ./lsp.nix
    ./telescope.nix
    ./which-key.nix
    #./nvim-cmp.nix
    ./format.nix
    ./git.nix
    ./ai.nix
    ./http.nix
    ./candy.nix
    ./scrollbar.nix
    ./indent.nix
    ./oil.nix
    ./presence.nix
    ./markdown.nix
    ./trouble.nix
    # ./testaustime.nix
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

    list = true;
    listchars = "tab:␋\ ,trail:␠,precedes:«,extends:»";

    cursorline = true;
    cursorlineopt = "number";

    scrolloff = 8;
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
