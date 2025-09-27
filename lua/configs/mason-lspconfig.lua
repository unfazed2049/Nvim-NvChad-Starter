-- 检查 mason-lspconfig 是否可用
local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
  vim.notify("mason-lspconfig 插件未找到", vim.log.levels.ERROR)
  return
end

local languages = require("configs.languages")
local capabilities = require("nvchad.configs.lspconfig").capabilities
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init

-- 获取必须安装的 LSP 服务器列表
local required_lsp_servers = {}

-- 转换 mason 名称到 lsp 服务器名称
for lang, config in pairs(languages.language_configs) do
  if config.lsp and config.lsp.server and config.lsp.mason_name then
    if languages.is_required_language(lang) then
      table.insert(required_lsp_servers, config.lsp.server)
    end
  end
end

-- 使用 vim.lsp.config 设置服务器
local function setup_lsp_server(server_name, lang_config)
  local lsp_config = {
    capabilities = capabilities,
    on_attach = on_attach,
    on_init = on_init,
  }

  if lang_config and lang_config.lsp and lang_config.lsp.settings then
    lsp_config.settings = lang_config.lsp.settings
  end

  -- 使用新的 vim.lsp.config API
  vim.lsp.config[server_name] = lsp_config
  vim.lsp.enable(server_name)
end

-- 根据文件类型自动设置 LSP
local function setup_lsp_for_filetype()
  local filetype = vim.bo.filetype
  local lang, config = languages.get_language_by_filetype(filetype)

  if not lang or not config or not config.lsp or not config.lsp.server then
    return
  end

  local server = config.lsp.server
  local mason_name = config.lsp.mason_name

  -- 检查 LSP 服务器是否已经激活
  local active_clients = vim.lsp.get_clients({ name = server })
  if #active_clients > 0 then
    return
  end

  local mason_registry_ok, mason_registry = pcall(require, "mason-registry")
  if not mason_registry_ok then
    return
  end

  -- 如果是可选语言，检查是否已安装，如果没有则安装
  if languages.is_optional_language(lang) then
    if not mason_registry.is_installed(mason_name) then
      vim.notify("🔧 自动安装 " .. mason_name .. " 用于 " .. filetype .. " 文件...")
      local package = mason_registry.get_package(mason_name)
      package:install():once("closed", function()
        if package:is_installed() then
          vim.notify("✅ " .. mason_name .. " 安装成功!")
          vim.schedule(function()
            setup_lsp_server(server, config)
            vim.cmd("LspRestart")
          end)
        else
          vim.notify("❌ 安装 " .. mason_name .. " 失败", vim.log.levels.ERROR)
        end
      end)
      return
    end
  end

  -- 如果已安装，直接设置
  if mason_registry.is_installed(mason_name) then
    setup_lsp_server(server, config)
  end
end

-- 设置 mason-lspconfig
mason_lspconfig.setup({
  automatic_installation = true,
  ensure_installed = required_lsp_servers,
})

-- 文件进入时自动设置 LSP
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "*",
  callback = setup_lsp_for_filetype,
})

-- 设置处理器
if mason_lspconfig.setup_handlers then
  mason_lspconfig.setup_handlers({
    function(server_name)
      -- 查找对应的语言配置
      local lang_config = nil
      for _, config in pairs(languages.language_configs) do
        if config.lsp and config.lsp.server == server_name then
          lang_config = config
          break
        end
      end

      setup_lsp_server(server_name, lang_config)
    end,
  })
end