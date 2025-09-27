local languages = require("configs.languages")
local lint = require("lint")

-- 根据语言配置生成 linter 映射
local linters_by_ft = {}

for lang, config in pairs(languages.language_configs) do
  for _, filetype in ipairs(config.filetypes) do
    if config.linters and #config.linters > 0 then
      linters_by_ft[filetype] = config.linters
    end
  end
end

lint.linters_by_ft = linters_by_ft

-- 自动运行 lint
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
  callback = function()
    local filetype = vim.bo.filetype
    if lint.linters_by_ft[filetype] then
      -- 检查 linter 是否已安装
      local mason_registry = require("mason-registry")
      local available_linters = {}

      for _, linter in ipairs(lint.linters_by_ft[filetype]) do
        if mason_registry.is_installed(linter) then
          table.insert(available_linters, linter)
        end
      end

      if #available_linters > 0 then
        lint.try_lint(available_linters)
      end
    end
  end,
})

-- 根据文件类型自动安装 linter
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function()
    local filetype = vim.bo.filetype
    local lang, config = languages.get_language_by_filetype(filetype)

    if not lang or not config or not config.linters or #config.linters == 0 then
      return
    end

    -- 如果是可选语言，自动安装所需的 linter
    if languages.is_optional_language(lang) then
      local mason_registry = require("mason-registry")
      for _, linter in ipairs(config.linters) do
        if not mason_registry.is_installed(linter) then
          vim.notify("🔧 自动安装 " .. linter .. " 用于 " .. filetype .. " 文件...")
          local package = mason_registry.get_package(linter)
          package:install():once("closed", function()
            if package:is_installed() then
              vim.notify("✅ " .. linter .. " 安装成功!")
            else
              vim.notify("❌ 安装 " .. linter .. " 失败", vim.log.levels.ERROR)
            end
          end)
        end
      end
    end
  end,
})