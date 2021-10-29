local M = {}

local prettier = {
  formatCommand = "./node_modules/.bin/prettier --stdin-filepath=${INPUT}",
  formatStdin = true
}

local eslint = {
  lintCommand = "./node_modules/.bin/eslint -f visualstudio --stdin --stdin-filename ${INPUT}",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = { "%f(%l,%c): %tarning %m", "%f(%l,%c): %rror %m" }
}

local shellcheck = {
  lintCommand = "shellcheck -f gcc -x -",
  lintStdin = true,
  lintFormats = {
    "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m"
  }
}

local shfmt = {
  -- brew install shfmt
  formatCommand = "shfmt -ci -s -bn",
  formatStdin = true
}

local luaformat = {
  -- luarocks install --server=https://luarocks.org/dev luaformatter
  formatCommand = "lua-format -i ${--tab-width:tabSize} ${--indent-width:tabSize} ${--continuation-indent-width:tabSize} --spaces-inside-table-braces --single-quote-to-double-quote --chop-down-parameter --chop-down-table --chop-down-kv-table --extra-sep-at-table-end --column-limit=100",
  formatStdin = true
}

local vint = {
  -- brew install vint --HEAD
  lintCommand = "vint -f '{file_path}:{line_number}:{column_number}: {severity}: {description} (see: {reference})' --enable-neovim -",
  -- stdin needs vint >= 0.4
  lintStdin = true,
  lintFormats = { "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m" }
}

local checkmake = { lintCommand = "checkmake", lintStdin = true }

-- brew install yamllint
local yamllint = { lintCommand = "yamllint -f parsable -", lintStdin = true }

local flake8 = {
  lintCommand = "flake8 --stdin-display-name ${INPUT} -",
  lintStdin = true,
  lintFormats = { "%f:%l:%c: %m" }
}

local phpstan = {
  lintCommand = "./vendor/bin/phpstan analyze --error-format raw --no-progress"
}

local bladeFormatter = {
  formatCommand = "blade-formatter --stdin ${--indent-size:tabSize}",
  formatStdin = true
}

local rustywind = {
  -- yarn global add rustywind
  formatCommand = "rustywind --stdin",
  formatStdin = true
}

local fixjson = {
  -- yarn global add fixjson
  formatCommand = "fixjson",
  formatStdin = true
}

local eslintPrettier = { prettierLocal, eslint }

M.config = {
  init_options = { documentFormatting = true },
  settings = {
    rootMarkers = { "package.json", ".git" },
    languages = {
      -- lua = { selene, stylua },
      -- typescript = { prettierLocal },
      -- javascript = eslintPrettier,
      -- typescriptreact = eslintPrettier,
      -- javascriptreact = eslintPrettier,
      -- ["typescript.tsx"] = eslintPrettier,
      -- ["javascript.tsx"] = eslintPrettier,
      -- yaml = { prettierLocal },
      -- json = { prettierGlobal },
      -- html = { prettierLocal },
      -- scss = { prettierLocal },
      -- css = { prettierLocal },
      -- markdown = { prettierLocal, markdownlint },
      -- sh = { shellcheck },
    },
  },
}

M.config.filetypes = {}
for ft, _ in pairs(M.config.settings.languages) do
  table.insert(M.config.filetypes, ft)
end

M.formatted_languages = {}

for lang, tools in pairs(M.config.settings.languages) do
  for _, tool in pairs(tools) do
    if tool.formatCommand then
      M.formatted_languages[lang] = true
    end
  end
end

return M
