local languages = require("configs.languages")

-- 获取必须安装的 Treesitter 解析器
local required_tools = languages.get_required_tools()
local ensure_installed = vim.deepcopy(required_tools.treesitter)

-- 添加基础必需的解析器
vim.list_extend(ensure_installed, { "vim", "vimdoc" })

local options = {
  ensure_installed = ensure_installed,

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },

  -- 自动安装打开文件的解析器
  auto_install = true,
  sync_install = false,

  -- 增量选择配置
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
}

-- 根据文件类型自动安装 Treesitter 解析器
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "*",
  callback = function()
    local filetype = vim.bo.filetype
    local lang, config = languages.get_language_by_filetype(filetype)

    if not lang or not config or not config.treesitter then
      return
    end

    local parsers = {}
    if type(config.treesitter) == "table" then
      parsers = config.treesitter
    elseif type(config.treesitter) == "string" then
      parsers = { config.treesitter }
    end

    -- 如果是可选语言，自动安装 Treesitter 解析器
    if languages.is_optional_language(lang) then
      local ts_utils = require("nvim-treesitter.utils")
      for _, parser in ipairs(parsers) do
        if type(parser) == "string" and not ts_utils.is_available(parser) then
          vim.notify("🌳 自动安装 Treesitter 解析器 " .. parser .. " 用于 " .. filetype .. " 文件...")
          vim.cmd("TSInstall " .. parser)
        end
      end
    end
  end,
})

return options