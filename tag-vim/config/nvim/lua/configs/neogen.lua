local M = {}

function M.config()
  local neogen = safe_require("neogen")

  neogen.setup({
    enable = true,
    typescript = {
      template = {
        annotation_convention = "tsdoc",
        tsdoc = {
          { nil, "/**" },
          { nil, " * $1" },
          { "parameters", " * @param %s $1" },
          { "return_statement", " * @return %s $1" },
          { nil, " */" },
        },
      },
    },
  })
end

return M
