require("nvchad.configs.lspconfig").defaults()

-- This file now mainly handles server-specific configurations
-- Auto-installation and setup is handled by mason-lspconfig.lua
-- Using new vim.lsp.config API instead of deprecated lspconfig

local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- Server-specific configurations using vim.lsp.config
local servers = {
  html = {},
  cssls = {},
  ts_ls = {
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            vim.fn.expand("$VIMRUNTIME/lua"),
            vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
            vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  },
  pyright = {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "workspace",
        },
      },
    },
  },
}

-- Setup servers with configurations using vim.lsp.config
for server, config in pairs(servers) do
  config.on_attach = on_attach
  config.on_init = on_init
  config.capabilities = capabilities

  -- Use vim.lsp.config instead of lspconfig
  vim.lsp.config[server] = config
end

-- Enable the servers
local server_names = vim.tbl_keys(servers)
vim.lsp.enable(server_names)
