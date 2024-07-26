{ config, pkgs, inputs, ... }:

{
    # Useful plugin to show you pending keybinds.
    # https://nix-community.github.io/nixvim/plugins/which-key/index.html
    plugins.which-key = {
      enable = true;

      # Document existing key chains
      registrations = {
	"<leader>d" = {
	  group = "[D]ocument";
	};
	"<leader>r" = {
	  group = "[R]ename";
	};
	"<leader>s" = {
	  group = "L[S]P";
	};
	"<leader>f" = {
	  group = "[F]iles";
	};
	"<leader>w" = {
	  group = "[W]orkspace";
	};
	"<leader>t" = {
	  group = "[T]oggle";
	};
	"<leader>h" = {
	  group = "Git [H]unk";
	};
      };
    };
}
