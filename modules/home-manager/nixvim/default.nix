{ pkgs, lib, config, ... }:
let
  cfg = config.modules.nixvim;
in {
  options.modules.nixvim = { enable = lib.mkEnableOption "nixvim"; };
  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;

      # Ensure ripgrep is installed
      extraPackages = with pkgs; [
        ripgrep
      ];

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
        # Indentation of 2
        shiftwidth = 2;

        # Display relative line numbers
        number = true;
        relativenumber = true;

        # Ignore case in search patterns, unless an uppercase character is included
        ignorecase = true;
        smartcase = true;

        # Not needed thanks to lualine
        showmode = false;
      };

      globals = {
        # Set space to be the leader key
        mapleader = " ";
      };

      keymaps = [
        # Buffer navigation
        {
          action = "<Cmd>bp<CR>";
          key = "[b";
          mode = "n";
          options = { desc = "Previous buffer"; };
        }
        {
          action = "<Cmd>bn<CR>";
          key = "]b";
          mode = "n";
          options = { desc = "Next buffer"; };
        }
        {
          action = "<Cmd>bd<CR>";
          key = "<leader>q";
          mode = "n";
          options = { desc = "Close buffer"; };
        }

        # Split navigation
        {
          action = "<C-w>h";
          key = "<C-h>";
          mode = "n";
          options = { desc = "Move to left split"; };
        }
        {
          action = "<C-w>j";
          key = "<C-j>";
          mode = "n";
          options = { desc = "Move to below split"; };
        }
        {
          action = "<C-w>k";
          key = "<C-k>";
          mode = "n";
          options = { desc = "Move to above split"; };
        }
        {
          action = "<C-w>l";
          key = "<C-l>";
          mode = "n";
          options = { desc = "Move to right split"; };
        }

        # Split sizing
        {
          action = "<Cmd>resize +2<CR>";
          key = "<C-Up>";
          mode = [ "n" "t" ];
          options = { desc = "Make split taller"; };
        }
        {
          action = "<Cmd>vertical resize -2<CR>";
          key = "<C-Left>";
          mode = [ "n" "t" ];
          options = { desc = "Make split thinner"; };
        }
        {
          action = "<Cmd>vertical resize +2<CR>";
          key = "<C-Right>";
          mode = [ "n" "t" ];
          options = { desc = "Make split wider"; };
        }
        {
          action = "<Cmd>resize -2<CR>";
          key = "<C-Down>";
          mode = [ "n" "t" ];
          options = { desc = "Make split shorter"; };
        }

        # File explorer
        {
          action = "<Cmd>Neotree toggle<CR>";
          key = "<leader>e";
          mode = "n";
          options = { desc = "Toggle explorer"; };
        }

        # Buffer outline
        {
          action = "<Cmd>Lspsaga outline<CR>";
          key = "<leader>o";
          mode = "n";
          options = { desc = "Toggle outline"; };
        }

        # Terminal
        {
          action = "<Cmd>ToggleTerm direction='float'<CR>";
          key = "<leader>tF";
          mode = [ "n" "t" ];
          options = { desc = "Toggle floating terminal"; };
        }
        {
          action = "<Cmd>ToggleTerm direction='horizontal'<CR>";
          key = "<leader>tH";
          mode = [ "n" "t" ];
          options = { desc = "Toggle horizontal terminal"; };
        }
        {
          action = "<Cmd>ToggleTerm direction='vertical'<CR>";
          key = "<leader>tV";
          mode = [ "n" "t" ];
          options = { desc = "Toggle vertical terminal"; };
        }

        # Find
        {
          action = "<Cmd>Telescope find_files<CR>";
          key = "<leader>ff";
          mode = "n";
          options = { desc = "Find file"; };
        }
        {
          action = "<Cmd>Telescope oldfiles<CR>";
          key = "<leader>fo";
          mode = "n";
          options = { desc = "Find previously open file"; };
        }
        {
          action = "<Cmd>Telescope buffers<CR>";
          key = "<leader>fb";
          mode = "n";
          options = { desc = "Find buffer"; };
        }
        {
          action = "<Cmd>Telescope live_grep<CR>";
          key = "<leader>fs";
          mode = "n";
          options = { desc = "Find string"; };
        }
        {
          action = "<Cmd>Lspsaga finder<CR>";
          key = "<leader>fr";
          mode = "n";
          options = { desc = "Find references"; };
        }

        # Git
        {
          action = "<Cmd>Telescope git_commits<CR>";
          key = "<leader>gc";
          mode = "n";
          options = { desc = "Git commits"; };
        }
        {
          action = "<Cmd>Telescope git_status<CR>";
          key = "<leader>gs";
          mode = "n";
          options = { desc = "Git status"; };
        }
        {
          action = "<Cmd>Telescope git_branches<CR>";
          key = "<leader>gb";
          mode = "n";
          options = { desc = "Git branches"; };
        }
        {
          action = "<Cmd>Telescope git_stash<CR>";
          key = "<leader>gt";
          mode = "n";
          options = { desc = "Git stashes"; };
        }

        # LSP
        {
          action = "<Cmd>Lspsaga code_action<CR>";
          key = "<leader>la";
          mode = "n";
          options = { desc = "Code action"; };
        }
        {
          action = "<Cmd>Lspsaga peek_definition<CR>";
          key = "<leader>ld";
          mode = "n";
          options = { desc = "Peek definition"; };
        }
        {
          action = "<Cmd>Lspsaga peek_type_definition<CR>";
          key = "<leader>lt";
          mode = "n";
          options = { desc = "Peek type definition"; };
        }
        {
          action = "<Cmd>Lspsaga hover_doc<CR>";
          key = "<leader>lh";
          mode = "n";
          options = { desc = "Hover documentation"; };
        }
        {
          action = "<Cmd>Lspsaga rename<CR>";
          key = "<leader>lr";
          mode = "n";
          options = { desc = "Rename symbol"; };
        }

        # Default mapping overrides
        {
          # Leader's default behaviour should be ignored
          action = "";
          key = "<leader>";
        }
        {
          # [d should use Lspsaga to cycle diagnostics
          action = "<Cmd>Lspsaga diagnostic_jump_prev<CR>";
          key = "[d";
          mode = "n";
          options = { desc = "Previous diagnostic"; };
        }
        {
          # ]d should use Lspsaga to cycle diagnostics
          action = "<Cmd>Lspsaga diagnostic_jump_next<CR>";
          key = "]d";
          mode = "n";
          options = { desc = "Next diagnostic"; };
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
        # Automatic session restoration
        auto-session.enable = true;

        # Tabline
        barbar.enable = true;

        # No-delay escape from insert mode
        better-escape.enable = true;

        # Commenting
        comment.enable = true;

        # Git decorations in buffers
        gitsigns.enable = true;

        # Indent-level indicators
        indent-blankline.enable = true;

        # Language server protocol
        lsp = {
          enable = true;
          servers = {
            # Nix
            nixd.enable = true;

            # Python
            pyright.enable = true;

            # TypeScript & JavaScript
            tsserver.enable = true;
          };
        };

        # LSP utilities
        lspsaga = {
          enable = true;

          # Override the default code action menu's quit keymap
          # In addition to the default, allow Esc to close the menu
          codeAction.keys.quit = ["q" "<Esc>"];

          # Override some of the default reference finder keymaps
          finder.keys = {
            # In addition to the default, allow Esc to quit the reference finder
            quit = ["q" "<Esc>"];

            # In addition to the default, allow Enter to go to the reference
            toggleOrOpen = ["o" "<CR>"];
          };

          # Override some of the default outline keymaps
          outline.keys = {
            # In addition to the default, allow Esc to close the outline
            quit = ["q" "<Esc>"];

            # In addition to the default, allow Enter to jump to the node
            jump = ["e" "<CR>"];
          };

          # Remove the lightbulb from the status (leftmost) column
          lightbulb.sign = false;
        };

        # Status line
        lualine.enable = true;

        # Snippet engine
        luasnip.enable = true;

        # File explorer
        neo-tree.enable = true;

        # UI for messages, cmdline and popupmenu
        noice = {
          enable = true;

          # Needed to show @recording messages as notifications,
          # since their usual location is gone
          routes = [
            {
              view = "notify";
              filter = { event = "msg_showmode"; };
            }
          ];
        };

        # Notification manager
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
        telescope = {
          enable = true;
          extensions = {
            ui-select.enable = true;
          };
        };

        # Better terminal windows within Nvim
        toggleterm.enable = true;

        # Syntax highlighting
        treesitter.enable = true;
        treesitter-textobjects.enable = true;

        # Auto close / rename tags
        ts-autotag.enable = true;
        
        # Contextual comment style
        ts-context-commentstring.enable = true;

        # Keymap helper popup
        which-key = {
          enable = true;

          # Specify group names for common binding prefixes
          registrations = {
            "<leader>f" = { name = "+Find"; };
            "<leader>g" = { name = "+Git"; };
            "<leader>l" = { name = "+LSP"; };
            "<leader>t" = { name = "+Terminal"; };
          };
        };
      };
    };
  };
}
