return {
  -- Mason for managing LSP servers, formatters, and linters
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    event = "User FilePost",
    opts = require "configs.mason",
  },

  {
    "williamboman/mason-lspconfig.nvim",
    event = "User FilePost",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require "configs.mason-lspconfig"
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "User FilePost",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require "configs.mason-tool-installer"
    end,
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile", "BufWritePost" },
    config = function()
      require "configs.nvim-lint"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
  },

  -- Breadcrumbs
  {
    "Bekaboo/dropbar.nvim",
    lazy = false,
    -- Optional, but required for fuzzy finder support
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
  },

  -- {
  --   "typicode/bg.nvim",
  --   lazy = false,
  -- },


  -- {
  --   "JoosepAlviste/nvim-ts-context-commentstring",
  --   event = "BufRead",
  --   opts = {
  --     enable_autocmd = false,
  --   },
  --   config = function()
  --     local get_option = vim.filetype.get_option
  --     ---@diagnostic disable-next-line: duplicate-set-field
  --     vim.filetype.get_option = function(filetype, option)
  --       if option == "commentstring" then
  --         return require("ts_context_commentstring.internal").calculate_commentstring()
  --       else
  --         return get_option(filetype, option)
  --       end
  --     end
  --   end,
  -- },
  --



  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
  	"nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  	opts = require "configs.treesitter",
  },
}
