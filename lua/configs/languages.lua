-- 集中的语言配置文件
-- 定义必须安装和可选的语言支持，以及每种语言对应的工具

local M = {}

-- 必须安装的语言（无论是否打开对应文件都会安装）
M.required_languages = {
  "lua",
  "html",
  "css",
  "json",
  "markdown",
  "javascript",
  "typescript",
  "python",
  "go",
  "bash",
  "yaml",
  "toml",
  "vue",
  "less",
  "scss",
  "tailwindcss",
}

-- 可选语言（根据文件类型检测自动安装）
M.optional_languages = {
  "rust",
  "c",
  "cpp",
  "java",
  "svelte",
  "php",
  "ruby",
  "astro",
  "angular",
  "clojure",
  "make",
  "cmake",
  "conf",
  "dart",
  "elixir",
  "erlang",
  "csharp",
  "zig",
  "sql",
  "graphql",
  "kotlin",
  "perl",
  "terraform",
}

-- 语言配置：每种语言的完整工具链配置
M.language_configs = {
  lua = {
    -- 文件类型映射
    filetypes = { "lua" },
    -- LSP 配置
    lsp = {
      server = "lua_ls",
      mason_name = "lua-language-server",
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
    -- 格式化工具
    formatters = { "stylua" },
    -- 代码检查工具
    linters = { "luacheck" },
    -- Treesitter 解析器
    treesitter = "lua",
  },

  javascript = {
    filetypes = { "javascript", "js" },
    lsp = {
      server = "ts_ls",
      mason_name = "typescript-language-server",
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
          },
        },
      },
    },
    formatters = { "prettierd" },
    linters = { "eslint_d" },
    treesitter = "javascript",
  },

  typescript = {
    filetypes = { "typescript", "ts" },
    lsp = {
      server = "ts_ls",
      mason_name = "typescript-language-server",
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
          },
        },
      },
    },
    formatters = { "prettierd" },
    linters = { "eslint_d" },
    treesitter = "typescript",
  },

  javascriptreact = {
    filetypes = { "javascriptreact", "jsx" },
    lsp = {
      server = "ts_ls",
      mason_name = "typescript-language-server",
    },
    formatters = { "prettierd" },
    linters = { "eslint_d" },
    treesitter = "tsx",
  },

  typescriptreact = {
    filetypes = { "typescriptreact", "tsx" },
    lsp = {
      server = "ts_ls",
      mason_name = "typescript-language-server",
    },
    formatters = { "prettierd" },
    linters = { "eslint_d" },
    treesitter = "tsx",
  },

  python = {
    filetypes = { "python", "py" },
    lsp = {
      server = "pyright",
      mason_name = "pyright",
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
    formatters = { "black", "isort" },
    linters = { "pylint", "flake8" },
    treesitter = "python",
  },

  rust = {
    filetypes = { "rust", "rs" },
    lsp = {
      server = "rust_analyzer",
      mason_name = "rust-analyzer",
      settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
          },
          procMacro = {
            enable = true,
          },
        },
      },
    },
    formatters = { "rustfmt" },
    linters = {},
    treesitter = "rust",
  },

  go = {
    filetypes = { "go" },
    lsp = {
      server = "gopls",
      mason_name = "gopls",
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
        },
      },
    },
    formatters = { "gofmt", "goimports" },
    linters = {},
    treesitter = "go",
  },

  c = {
    filetypes = { "c" },
    lsp = {
      server = "clangd",
      mason_name = "clangd",
    },
    formatters = { "clang-format" },
    linters = {},
    treesitter = "c",
  },

  cpp = {
    filetypes = { "cpp", "cxx", "cc" },
    lsp = {
      server = "clangd",
      mason_name = "clangd",
    },
    formatters = { "clang-format" },
    linters = {},
    treesitter = "cpp",
  },

  html = {
    filetypes = { "html", "htm" },
    lsp = {
      server = "html",
      mason_name = "html-lsp",
      settings = {
        html = {
          completion = {
            attributeDefaultValue = "doublequotes",
          },
        },
      },
    },
    formatters = { "prettierd" },
    linters = {},
    treesitter = "html",
  },

  css = {
    filetypes = { "css" },
    lsp = {
      server = "cssls",
      mason_name = "css-lsp",
      settings = {
        css = {
          validate = true,
          lint = {
            unknownAtRules = "ignore",
          },
        },
      },
    },
    formatters = { "prettierd" },
    linters = {},
    treesitter = "css",
  },

  json = {
    filetypes = { "json", "jsonc" },
    lsp = {
      server = "jsonls",
      mason_name = "json-lsp",
    },
    formatters = { "prettierd" },
    linters = {},
    treesitter = "json",
  },

  yaml = {
    filetypes = { "yaml", "yml" },
    lsp = {
      server = "yamlls",
      mason_name = "yaml-language-server",
    },
    formatters = { "prettierd" },
    linters = {},
    treesitter = "yaml",
  },

  toml = {
    filetypes = { "toml" },
    lsp = {
      server = "taplo",
      mason_name = "taplo",
    },
    formatters = {},
    linters = {},
    treesitter = "toml",
  },

  bash = {
    filetypes = { "sh", "bash", "zsh" },
    lsp = {
      server = "bashls",
      mason_name = "bash-language-server",
    },
    formatters = { "shfmt" },
    linters = { "shellcheck" },
    treesitter = "bash",
  },

  java = {
    filetypes = { "java" },
    lsp = {
      server = "jdtls",
      mason_name = "jdtls",
    },
    formatters = { "google-java-format" },
    linters = {},
    treesitter = "java",
  },

  markdown = {
    filetypes = { "markdown", "md" },
    lsp = {},
    formatters = { "prettierd" },
    linters = {},
    treesitter = { "markdown", "markdown_inline" },
  },

  vue = {
    filetypes = { "vue" },
    lsp = {
      server = "vue_ls",
      mason_name = "vue-language-server",
      settings = {
        vue = {
          completion = {
            enable = true,
          },
        },
      },
    },
    formatters = { "prettierd" },
    linters = { "eslint_d" },
    treesitter = "vue",
  },

  svelte = {
    filetypes = { "svelte" },
    lsp = {
      server = "svelte",
      mason_name = "svelte-language-server",
      settings = {
        svelte = {
          plugin = {
            html = {
              completions = {
                enable = true,
                emmet = true,
              },
            },
            css = {
              completions = {
                enable = true,
                emmet = true,
              },
            },
          },
        },
      },
    },
    formatters = { "prettierd" },
    linters = { "eslint_d" },
    treesitter = "svelte",
  },

  php = {
    filetypes = { "php" },
    lsp = {
      server = "intelephense",
      mason_name = "intelephense",
    },
    formatters = { "php-cs-fixer" },
    linters = {},
    treesitter = "php",
  },

  ruby = {
    filetypes = { "ruby", "rb" },
    lsp = {
      server = "solargraph",
      mason_name = "solargraph",
    },
    formatters = { "rubocop" },
    linters = { "rubocop" },
    treesitter = "ruby",
  },

  -- Web 前端相关
  astro = {
    filetypes = { "astro" },
    lsp = {
      server = "astro",
      mason_name = "astro-language-server",
    },
    formatters = { "prettierd" },
    linters = { "eslint_d" },
    treesitter = "astro",
  },

  angular = {
    filetypes = { "html", "ts", "js" }, -- Angular 使用 HTML/TS
    lsp = {
      server = "angularls",
      mason_name = "angular-language-server",
    },
    formatters = { "prettierd" },
    linters = { "eslint_d" },
    treesitter = "typescript",
  },

  less = {
    filetypes = { "less" },
    lsp = {
      server = "cssls",
      mason_name = "css-lsp",
      settings = {
        css = {
          validate = true,
          lint = {
            unknownAtRules = "ignore",
          },
        },
        less = {
          validate = true,
          lint = {
            unknownAtRules = "ignore",
          },
        },
      },
    },
    formatters = { "prettierd" },
    linters = {},
    treesitter = "css",
  },

  scss = {
    filetypes = { "scss", "sass" },
    lsp = {
      server = "cssls",
      mason_name = "css-lsp",
      settings = {
        css = {
          validate = true,
          lint = {
            unknownAtRules = "ignore",
          },
        },
        scss = {
          validate = true,
          lint = {
            unknownAtRules = "ignore",
          },
        },
      },
    },
    formatters = { "prettierd" },
    linters = {},
    treesitter = "scss",
  },

  -- 编程语言
  clojure = {
    filetypes = { "clojure", "clj", "cljs", "cljc" },
    lsp = {
      server = "clojure_lsp",
      mason_name = "clojure-lsp",
    },
    formatters = { "zprint" },
    linters = {},
    treesitter = "clojure",
  },

  dart = {
    filetypes = { "dart" },
    lsp = {
      server = "dartls",
      mason_name = "dart-language-server",
    },
    formatters = { "dart_format" },
    linters = {},
    treesitter = "dart",
  },

  elixir = {
    filetypes = { "elixir", "ex", "exs" },
    lsp = {
      server = "elixirls",
      mason_name = "elixir-ls",
    },
    formatters = { "mix" },
    linters = {},
    treesitter = "elixir",
  },

  erlang = {
    filetypes = { "erlang", "erl" },
    lsp = {
      server = "erlangls",
      mason_name = "erlang-ls",
    },
    formatters = {},
    linters = {},
    treesitter = "erlang",
  },

  csharp = {
    filetypes = { "cs" },
    lsp = {
      server = "omnisharp",
      mason_name = "omnisharp",
    },
    formatters = { "csharpier" },
    linters = {},
    treesitter = "c_sharp",
  },

  zig = {
    filetypes = { "zig" },
    lsp = {
      server = "zls",
      mason_name = "zls",
    },
    formatters = { "zigfmt" },
    linters = {},
    treesitter = "zig",
  },

  kotlin = {
    filetypes = { "kotlin", "kt" },
    lsp = {
      server = "kotlin_language_server",
      mason_name = "kotlin-language-server",
    },
    formatters = { "ktlint" },
    linters = { "ktlint" },
    treesitter = "kotlin",
  },

  perl = {
    filetypes = { "perl", "pl", "pm" },
    lsp = {
      server = "perlnavigator",
      mason_name = "perlnavigator",
    },
    formatters = { "perltidy" },
    linters = {},
    treesitter = "perl",
  },

  -- 数据和配置
  sql = {
    filetypes = { "sql" },
    lsp = {
      server = "sqlls",
      mason_name = "sqlls",
    },
    formatters = { "sql-formatter" },
    linters = {},
    treesitter = "sql",
  },

  graphql = {
    filetypes = { "graphql", "gql" },
    lsp = {
      server = "graphql",
      mason_name = "graphql-language-service-cli",
    },
    formatters = { "prettierd" },
    linters = {},
    treesitter = "graphql",
  },

  terraform = {
    filetypes = { "terraform", "tf", "hcl" },
    lsp = {
      server = "terraformls",
      mason_name = "terraform-ls",
    },
    formatters = { "terraform_fmt" },
    linters = { "tflint" },
    treesitter = "hcl",
  },

  -- 构建系统
  make = {
    filetypes = { "make", "makefile" },
    lsp = {},
    formatters = {},
    linters = {},
    treesitter = "make",
  },

  cmake = {
    filetypes = { "cmake" },
    lsp = {
      server = "cmake",
      mason_name = "cmake-language-server",
    },
    formatters = { "cmake_format" },
    linters = {},
    treesitter = "cmake",
  },

  conf = {
    filetypes = { "conf", "config", "cfg" },
    lsp = {},
    formatters = {},
    linters = {},
    treesitter = nil, -- 没有对应的 treesitter 解析器
  },

  -- TailwindCSS 支持
  tailwindcss = {
    filetypes = { "html", "css", "scss", "sass", "less", "vue", "svelte", "astro", "javascriptreact", "typescriptreact" },
    lsp = {
      server = "tailwindcss",
      mason_name = "tailwindcss-language-server",
      settings = {
        tailwindCSS = {
          classAttributes = { "class", "className", "classList", "ngClass" },
          lint = {
            cssConflict = "warning",
            invalidApply = "error",
            invalidConfigPath = "error",
            invalidScreen = "error",
            invalidTailwindDirective = "error",
            invalidVariant = "error",
            recommendedVariantOrder = "warning",
          },
          validate = true,
        },
      },
    },
    formatters = {},
    linters = {},
    treesitter = nil, -- TailwindCSS 本身不需要 treesitter
  },
}

-- 根据文件类型获取语言配置
function M.get_language_by_filetype(filetype)
  for lang, config in pairs(M.language_configs) do
    if vim.tbl_contains(config.filetypes, filetype) then
      return lang, config
    end
  end
  return nil, nil
end

-- 获取所有需要安装的工具（LSP、格式化、linter）
function M.get_required_tools()
  local tools = {
    lsp = {},
    formatters = {},
    linters = {},
    treesitter = {},
  }

  for _, lang in ipairs(M.required_languages) do
    local config = M.language_configs[lang]
    if config then
      -- LSP
      if config.lsp and config.lsp.mason_name then
        table.insert(tools.lsp, config.lsp.mason_name)
      end
      -- 格式化工具
      for _, formatter in ipairs(config.formatters or {}) do
        if not vim.tbl_contains(tools.formatters, formatter) then
          table.insert(tools.formatters, formatter)
        end
      end
      -- Linter
      for _, linter in ipairs(config.linters or {}) do
        if not vim.tbl_contains(tools.linters, linter) then
          table.insert(tools.linters, linter)
        end
      end
      -- Treesitter
      if config.treesitter then
        ---@type string[]
        local parsers
        if type(config.treesitter) == "table" then
          parsers = config.treesitter
        elseif type(config.treesitter) == "string" then
          parsers = { config.treesitter }
        else
          parsers = {}
        end

        for _, parser in ipairs(parsers) do
          if type(parser) == "string" and not vim.tbl_contains(tools.treesitter, parser) then
            table.insert(tools.treesitter, parser)
          end
        end
      end
    end
  end

  return tools
end

-- 检查语言是否为可选安装
function M.is_optional_language(lang)
  return vim.tbl_contains(M.optional_languages, lang)
end

-- 检查语言是否为必须安装
function M.is_required_language(lang)
  return vim.tbl_contains(M.required_languages, lang)
end

return M
