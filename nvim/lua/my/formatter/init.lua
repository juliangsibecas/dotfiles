local vim = vim
local formatter = require("formatter")

--[[ local eslintConfig = function()
  return {
    exe = "eslint_d",
    args = { "--stdin", "--stdin-filename", vim.api.nvim_buf_get_name(0), "--fix-to-stdout" },
    stdin = true,
  }
end ]]

local prettierConfig = function()
  return {
    exe = "prettier",
    args = { "--stdin-filepath", vim.fn.shellescape(vim.api.nvim_buf_get_name(0)), "--single-quote" },
    stdin = true,
  }
end

local formatterConfig = {
  lua = {
    function()
      return {
        exe = "stylua",
        args = { "--indent-width", 2, "--indent-type", "Spaces" },
        stdin = false,
      }
    end,
  },
  python = {
    function()
      return {
        exe = "black",
        args = { "-q", "-" },
        stdin = true,
      }
    end,
  },
}

local commonFT = {
  "css",
  "scss",
  "html",
  "javascript",
  "typescript",
  "typescriptreact",
  "json",
}

for _, ft in ipairs(commonFT) do
  formatterConfig[ft] = { prettierConfig }
end

formatter.setup({
  logging = true,
  filetype = formatterConfig,
})

vim.api.nvim_exec(
  [[
    augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost * FormatWrite
    augroup END
  ]],
  true
)
