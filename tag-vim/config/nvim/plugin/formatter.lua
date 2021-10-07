local eslint = function()
  return {
    exe = "eslint_d",
    args = {"--fix", "--cache", "--stdin-filename", vim.api.nvim_buf_get_name(0)},
    stdin = false
  }
end

local prettier = function()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
    stdin = true
  }
end

require("formatter").setup(
  {
    logging = true,
    filetype = {
      javascript = {prettier, eslint},
      typescript = {prettier, eslint},
      ["typescript.tsx"] = {prettier, eslint},
      typescriptreact = {prettier, eslint},
      css = {prettier, eslint},
      lua = {
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      }
    }
  }
)

vim.api.nvim_exec(
  [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.ts,*.tsx FormatWrite
  autocmd BufWritePost *.lua FormatWrite
augroup END
]],
  true
)
