local languages = require("configs.languages")

-- 根据语言配置生成格式化工具映射
local formatters_by_ft = {}

for lang, config in pairs(languages.language_configs) do
  for _, filetype in ipairs(config.filetypes) do
    if config.formatters and #config.formatters > 0 then
      formatters_by_ft[filetype] = config.formatters
    end
  end
end

-- 特殊处理 Python 格式化
formatters_by_ft.python = function(bufnr)
  local conform = require("conform")
  if conform.get_formatter_info("ruff_format", bufnr).available then
    return { "ruff_format" }
  else
    return { "isort", "black" }
  end
end

local options = {
  formatters = {
    beautysh = {
      prepend_args = { "--indent-size", "4" },
    },
  },
  formatters_by_ft = formatters_by_ft,

  format_on_save = {
    timeout_ms = 2000,
    lsp_fallback = true,
  },
}

return options
