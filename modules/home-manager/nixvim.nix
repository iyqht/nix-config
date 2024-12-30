{pkgs, ...}: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        transparent_background = true;
        flavor = "macchiato";
      };
    };
    globals.mapleader = " ";
    opts = {
      # Enable relative line numbers
      number = true;
      relativenumber = true;

      # Set tabs to 2 spaces
      tabstop = 2;
      softtabstop = 2;
      showtabline = 1;
      expandtab = true;

      # Enable auto indenting and set it to spaces
      smartindent = true;
      shiftwidth = 2;

      # Enable smart indenting (see https://stackoverflow.com/questions/1204149/smart-wrap-in-vim)
      breakindent = true;

      # Enable incremental searching
      hlsearch = true;
      incsearch = true;

      # Enable text wrap
      wrap = true;

      # Better splitting
      splitbelow = true;
      splitright = true;

      # Enable mouse mode
      mouse = "a"; # Mouse

      # Enable ignorecase + smartcase for better searching
      ignorecase = true;
      smartcase = true; # Don't ignore case with capitals
      grepprg = "rg --vimgrep";
      grepformat = "%f:%l:%c:%m";

      # Decrease updatetime
      updatetime = 50; # faster completion (4000ms default)

      # Set completeopt to have a better completion experience
      completeopt = ["menuone" "noselect" "noinsert"]; # mostly just for cmp

      # Enable persistent undo history
      swapfile = false;
      backup = false;
      undofile = true;

      # Enable 24-bit colors
      termguicolors = true;

      # Enable the sign column to prevent the screen from jumping
      signcolumn = "yes";

      # Enable cursor line highlight
      cursorline = true; # Highlight the line where the cursor is located

      # Set fold settings
      # These options were reccommended by nvim-ufo
      # See: https://github.com/kevinhwang91/nvim-ufo#minimal-configuration
      foldcolumn = "0";
      foldlevel = 99;
      foldlevelstart = 99;
      foldenable = true;

      # Always keep 8 lines above/below cursor unless at start/end of file
      scrolloff = 8;

      # Place a column line
      # colorcolumn = "80";

      # Reduce which-key timeout to 10ms
      timeoutlen = 10;

      # Set encoding type
      encoding = "utf-8";
      fileencoding = "utf-8";

      # More space in the neovim command line for displaying messages
      cmdheight = 0;

      # We don't need to see things like INSERT anymore
      showmode = false;

      list = true;
      smoothscroll = true;
      listchars = "nbsp:+,tab:→\ ,space:·,trail:-,eol:↲,conceal:┊,extends:<,precedes:>";
      # go to previous/next line with h,l,left arrow and right arrow
      # when cursor reaches end/beginning of line
      whichwrap = "<>[]hl";
    };
    viAlias = true;
    vimAlias = true;
    keymaps = [
      {
        mode = ["n"];
        key = ";";
        action = ":";
        options.desc = ":";
      }
      {
        mode = "n";
        key = "<leader>ff";
        action = ''
          <cmd>Telescope find_files<cr>
        '';
        options.desc = "Find file";
      }
      {
        mode = "n";
        key = "<leader>fo";
        action = ''
          <cmd>Telescope oldfiles<cr>
        '';
        options.desc = "Find old file";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = ''
          <cmd>Telescope live_grep<cr>
        '';
        options.desc = "Find word";
      }
      {
        mode = "n";
        key = "<c-n>";
        action = ''
          <cmd>NvimTreeToggle<cr>
        '';
        options.desc = "Toggle nvim tree";
      }
      {
        mode = "";
        key = "<ESC>";
        action = ''
          <ESC><cmd>noh<cr>
        '';
        options.desc = "Turn off highlight";
      }
      {
        mode = ["n" "v"];
        key = "<leader>m";
        action = ''
          <cmd>lua require("notify").dismiss()
        '';
        options.desc = "Dismiss notification";
      }
    ];
    extraConfigLua = ''
      vim.filetype.add {
        extension = { rasi = 'rasi' },
        pattern = {
          ['.*/hypr/.*%.conf'] = 'hyprlang',
        },
      }
      local ft = require 'Comment.ft'
      ft.hyprlang = '#%s'
    '';
    plugins = {
      alpha = {
        enable = true;
        theme = "theta";
      };
      barbar = {
        enable = true;
        keymaps = {
          close.key = "<leader>x";
          next.key = "<Tab>";
          previous.key = "<S-Tab>";
        };
      };
      bufferline = {
        enable = true;
        settings.options = {
          closeCommand = "BufferClose";
          diagnostics = "nvim_lsp";
          # diagnostics_indicator = ''
          #   function(count, level, diagnostics_dict, context)
          #     local icon = level:match("error") and " " or " "
          #     return " " .. icon .. count
          #   end
          # '';
          separator_style = "slant";
        };
      };
      cmp = {
        enable = true;
        cmdline = {
          "/" = {
            mapping = {__raw = "cmp.mapping.preset.cmdline()";};
            sources = [{name = "buffer";}];
          };
          "?" = {
            mapping = {__raw = "cmp.mapping.preset.cmdline()";};
            sources = [{name = "buffer";}];
          };
          ":" = {
            mapping = {__raw = "cmp.mapping.preset.cmdline()";};
            sources = [
              {name = "path";}
              {
                name = "cmdline";
                option = {
                  ignore_cmds = ["Man" "!"];
                };
              }
            ];
          };
        };
        settings = {
          snippet.expand = ''
            function(args)
              require("luasnip").lsp_expand(args.body)
            end
          '';
          sources = [
            {
              name = "nvim_lsp";
              keyword_length = 3;
            }
            {name = "nvim_lsp_signature_help";}
            {name = "emoji";}
            {
              name = "buffer"; # text within current buffer
              option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
              keyword_length = 2;
            }
            {
              name = "cmdline";
            }
            {
              name = "cmp-cmdline-history";
            }
            {
              name = "async_path"; # file system paths
            }
            {
              name = "luasnip"; # snippets
            }
          ];
          window = {
            completion.border = "solid";
            documentation.border = "solid";
          };
          mapping = {
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<C-j>" = "cmp.mapping.select_next_item()";
            "<C-k>" = "cmp.mapping.select_prev_item()";
            "<C-e>" = "cmp.mapping.abort()";
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
          };
        };
      };
      cmp-async-path.enable = true;
      cmp-buffer.enable = true;
      cmp-cmdline.enable = true;
      cmp-cmdline-history.enable = true;
      cmp-emoji.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-nvim-lsp-signature-help.enable = true;
      cmp_luasnip.enable = true;
      comment = {
        enable = true;
        settings = {
          ignore = "^$";
          opleader.line = "<leader>/";
          toggler.line = "<leader>/";
        };
      };
      conform-nvim = {
        enable = true;
        settings = {
          formatOnSave = {
            lspFallback = true;
            timeoutMs = 500;
          };
          formatAfterSave = {
            lspFallback = true;
          };
          formatters_by_ft = {
            nix = ["alejandra"];
            "_" = [];
          };
          notify_on_error = true;
        };
      };
      fidget.enable = true;
      flash.enable = true;
      friendly-snippets.enable = true;
      illuminate.enable = true;
      indent-blankline.enable = true;
      lint = {
        enable = true;
        lintersByFt = {
          nix = ["nix"];
        };
      };
      lsp = {
        enable = true;
        servers = {
          nil_ls = {
            enable = true;
            filetypes = ["nix"];
          };
          nixd = {
            enable = true;
            filetypes = ["nix"];
          };
        };
      };
      lsp-format.enable = true;
      lsp-lines.enable = true;
      lspkind = {
        enable = true;
        mode = "symbol_text";
        preset = "codicons";
        cmp.enable = true;
      };
      lspsaga = {
        enable = true;
        lightbulb.enable = false;
      };
      lualine = {
        enable = true;
        settings.options = {
          component_separators = {
            left = "";
            right = "";
          };
          section_separators = {
            left = "";
            right = "";
          };
        };
      };
      luasnip = {
        enable = true;
        settings = {
          enable_autosnippets = true;
          store_selection_keys = "<Tab>";
        };
        fromVscode = [
          {
            lazyLoad = true;
            paths = "${pkgs.vimPlugins.friendly-snippets}";
          }
        ];
      };
      noice = {
        enable = true;
        lsp = {
          override = {
            "vim.lsp.util.convert_input_to_markdown_lines" = true;
            "vim.lsp.util.stylize_markdown" = true;
            "cmp.entry.get_documentation" = true;
          };
        };
        # presets = {
        #   bottom_search = true;
        #   command_palette = true;
        #   long_message_to_split = true;
        #   inc_rename = false;
        #   lsp_doc_border = false;
        # };
      };
      none-ls = {
        enable = true;
        sources = {
          code_actions.statix.enable = true;
          completion.luasnip.enable = true;
          diagnostics = {
            deadnix.enable = true;
            statix.enable = true;
            trail_space.enable = true;
          };
          formatting = {
            alejandra.enable = true;
          };
          hover.dictionary.enable = true;
        };
      };
      notify = {
        enable = true;
        backgroundColour = "#000000";
        render = "minimal";
        topDown = false;
      };
      nvim-autopairs.enable = true;
      nvim-colorizer = {
        enable = true;
        userDefaultOptions = {
          AARRGGBB = true;
          RRGGBBAA = true;
          css = true;
          rgb_fn = true;
          tailwind = true;
          mode = "background";
        };
      };
      nvim-tree = {
        enable = true;
        hijackCursor = true;
        openOnSetup = true;
        respectBufCwd = true;
        syncRootWithCwd = true;
        diagnostics = {
          enable = true;
          showOnDirs = true;
          showOnOpenDirs = false;
          debounceDelay = 50;
          severity = {
            min = "error";
            max = "error";
          };
        };
        tab.sync = {
          open = true;
          close = true;
        };
        updateFocusedFile = {
          enable = true;
          updateRoot = true;
        };
      };
      nvim-ufo.enable = true;
      statuscol.enable = true;
      telescope = {
        enable = true;
        extensions = {
          file-browser.enable = true;
          fzf-native = {
            enable = true;
            settings.fuzzy = false;
          };
          ui-select.enable = true;
          undo.enable = true;
        };
      };
      treesitter = {
        enable = true;
        settings = {
          ensure_installed = [
            "nix"
            "hyprlang"
          ];
          options = {
            indent = true;
            incremental_selection.enable = true;
          };
        };
        folding = true;
        nixvimInjections = true;
      };
      treesitter-textobjects.enable = true;
      trouble.enable = true;
      undotree = {
        enable = true;
        settings = {
          SetFocusWhenToggle = true;
        };
      };
      web-devicons.enable = true;
      which-key.enable = true;
      wtf.enable = true;
      zen-mode.enable = true;
    };
  };
}
