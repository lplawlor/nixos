{ lib, config, ... }:
let
  cfg = config.modules.nixvim;
in {
  options.modules.nixvim = { enable = lib.mkEnableOption "nixvim"; };
  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;

      # Allow running via "vi" or "vim"
      viAlias = true;
      vimAlias = true;

      # Colorscheme
      colorschemes.catppuccin = {
        enable = true;
        settings.flavour = "mocha";
      };

      # Use system clipboard
      clipboard.register = "unnamedplus";

      opts = {
        number = true;
        shiftwidth = 2;
        relativenumber = true;
      };

      globals = {
        # Set space to be the leader key
        mapleader = " ";
      };

      keymaps = [
        # Split navigation
        {
          key = "<C-h>";
          mode = "n";
          action = "<C-w>h";
          options = { desc = "Move to left split"; };
        }
        {
          key = "<C-j>";
          mode = "n";
          action = "<C-w>j";
          options = { desc = "Move to below split"; };
        }
        {
          key = "<C-k>";
          mode = "n";
          action = "<C-w>k";
          options = { desc = "Move to above split"; };
        }
        {
          key = "<C-l>";
          mode = "n";
          action = "<C-w>l";
          options = { desc = "Move to right split"; };
        }

        # Split sizing
        {
          key = "<C-Up>";
          mode = "n";
          action = "<Cmd>resize +2<CR>";
          options = { desc = "Make split taller"; };
        }
        {
          key = "<C-Left>";
          mode = "n";
          action = "<Cmd>vertical resize -2<CR>";
          options = { desc = "Make split thinner"; };
        }
        {
          key = "<C-Right>";
          mode = "n";
          action = "<Cmd>vertical resize +2<CR>";
          options = { desc = "Make split wider"; };
        }
        {
          key = "<C-Down>";
          mode = "n";
          action = "<Cmd>resize -2<CR>";
          options = { desc = "Make split shorter"; };
        }

        # Leader actions
        {
          action = "";
          key = "<leader>";
          options = { desc = "No action for the leader key"; };
        }
        {
          action = "<Cmd>Neotree toggle<CR>";
          key = "<leader>e";
          mode = "n";
          options = { desc = "Toggle explorer"; };
        }
      ];

      # Extra files
      files = {
        "ftplugin/nix.lua" = {
          opts = {
            expandtab = true;
            shiftwidth = 2;
            tabstop = 2;
          };
        };
      };

      # Plugins
      plugins = {
        # Greeter
        alpha = {
          enable = true;
          theme = "dashboard";
        };

        # No-delay escape from insert mode
        better-escape.enable = true;

        # Comments
        comment.enable = true;

        # Git integrations
        gitsigns.enable = true;

        # Indent-level indicators
        indent-blankline.enable = true;

        # Language server protocol
        lsp = {
          enable = true;
          servers = {
            # Nix language
            nixd.enable = true;
          };
        };

        # Better auto-formatting
        lsp-format.enable = true;

        # Status line
        lualine.enable = true;

        # Snippet engine
        luasnip.enable = true;

        # File explorer
        neo-tree.enable = true;

        # UI notification popups
        notify.enable = true;

        # Automatically close pairs
        nvim-autopairs.enable = true;

        # Completion engine
        cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            sources = [
              {name = "nvim_lsp";}
              {name = "path";}
              {name = "buffer";}
              {name = "luasnip";}
            ];
            mapping = {
              # Enter -> Confirm completion
              "<CR>" = "cmp.mapping.confirm({ select = true })";

              # Tab -> Next completion option
              "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";

              # Shift + Tab -> Previous completion option
              "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            };
          };
        };
        
        # Highlight color strings
        nvim-colorizer.enable = true;

        # Finder / picker
        telescope.enable = true;

        # Syntax highlighting
        treesitter.enable = true;
        treesitter-textobjects.enable = true;

        # Auto close / rename tags
        ts-autotag.enable = true;
        
        # Contextual comment style
        ts-context-commentstring.enable = true;

        # Keymap popup
        which-key.enable = true;
      };
    };
  };
}
