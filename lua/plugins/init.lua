return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
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

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
