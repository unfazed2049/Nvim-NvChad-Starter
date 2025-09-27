local languages = require("configs.languages")

-- 获取必须安装的工具
local required_tools = languages.get_required_tools()

-- 合并所有必须安装的工具
local ensure_installed = {}
vim.list_extend(ensure_installed, required_tools.formatters)
vim.list_extend(ensure_installed, required_tools.linters)

-- Auto-install formatters and linters based on centralized language config
require("mason-tool-installer").setup({
  ensure_installed = ensure_installed,
  auto_update = true,
  run_on_start = true,
  start_delay = 3000,
  debounce_hours = 5,
})

-- 自动安装工具的功能现在由各自的配置文件处理：
-- - LSP: mason-lspconfig.lua
-- - Formatters: conform.lua (通过 nvim-lint.lua 间接)
-- - Linters: nvim-lint.lua
-- - Treesitter: treesitter.lua