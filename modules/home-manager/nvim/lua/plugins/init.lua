return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "folke/zen-mode.nvim",
    event = "VeryLazy",
  },
  -- {
  --   "nvimtools/none-ls.nvim",
  --   dependencies = {
  --     "nvimtools/none-ls-extras.nvim",
  --     "williamboman/mason.nvim",
  --   },
  --   event = "VeryLazy",
  --   opts = function()
  --     return require "configs.none-ls"
  --   end,
  -- },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require "configs.lint"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "hyprlang",
        "nix",
      },
    },
  },
}
