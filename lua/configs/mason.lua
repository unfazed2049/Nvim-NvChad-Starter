local languages = require("configs.languages")

-- 获取必须安装的工具
local required_tools = languages.get_required_tools()

-- 合并所有必须安装的工具
local ensure_installed = {}
vim.list_extend(ensure_installed, required_tools.lsp)
vim.list_extend(ensure_installed, required_tools.formatters)
vim.list_extend(ensure_installed, required_tools.linters)

return {
  ensure_installed = ensure_installed,

  PATH = "skip",

  ui = {
    icons = {
      package_pending = " ",
      package_installed = "󰄳 ",
      package_uninstalled = " 󰚌",
    },

    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>",
    },
  },

  max_concurrent_installers = 10,
}