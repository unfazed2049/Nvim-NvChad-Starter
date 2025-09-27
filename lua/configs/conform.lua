local options = {
  formatters = {
    beautysh = {
      prepend_args = { "--indent-size", "4" },
    },
  },
  formatters_by_ft = {
    bash = { "shellcheck", "shfmt" },
    lua = { "stylua" },
    c = { "clang-format", lsp_format = "last" },
    clojure = { "zprint" },
    cpp = { "clang-format", lsp_format = "last" },
    cs = { "csharpier" }, -- C#
    css = { "stylelint", "prettierd" },
    go = { "goimports", "gofmt" },
    haskell = { "ormolu" },
    html = { "prettierd" },
    java = { "google-java-format" },
    javascript = { "stylelint", "prettierd", "eslint_d" },
    javascriptreact = { "stylelint", "prettierd", "eslint_d" },
    lua = { "stylua" }, -- Stylua is already configured as the default formatter for Lua in NvChad, but keeping it here for reference
    python = function(bufnr)
      if conform.get_formatter_info("ruff_format", bufnr).available then
        return { "ruff_format" }
      else
        return { "isort", "black" }
      end
    end,
    ruby = { "rubocop" }, 
    rust = { "rustfmt" },
    svelte = { "stylelint", "prettierd", "eslint_d" },
    typescript = { "stylelint", "prettierd", "eslint_d" },
    typescriptreact = { "stylelint", "prettierd", "eslint_d" },
    vue = { "stylelint", "prettierd", "eslint_d" }
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 2000,
    lsp_fallback = true,
  },
}

return options
