{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # Useful plugin to show you pending keybinds.
  # https://nix-community.github.io/nixvim/plugins/which-key/index.html
  plugins.which-key = {
    enable = true;

    # Document existing key chains
    settings = {
      spec = [
        {
          __unkeyed-1 = "<leader>d";
          group = "[D]ocument";
        }
        {
          __unkeyed-1 = "<leader>r";
          group = "[R]ename";
        }
        {
          __unkeyed-1 = "<leader>s";
          group = "L[S]P";
        }
        {
          __unkeyed-1 = "<leader>f";
          group = "[F]iles";
        }
        {
          __unkeyed-1 = "<leader>x";
          group = "Trouble";
        }
        {
          __unkeyed-1 = "<leader>w";
          group = "[W]orkspace";
        }
        {
          __unkeyed-1 = "<leader>t";
          group = "[T]oggle";
        }
        {
          __unkeyed-1 = "<leader>h";
          group = "Git [H]unk";
        }
      ];
    };
  };
}
