local vim = vim
local formatter = require("formatter")

local prettierConfig = function()
	return {
		exe = "prettier",
		args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
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
	sh = {
		function()
			return {
				exe = "shfmt",
				args = { "-i", 2 },
				stdin = true,
			}
		end,
	},
	solidity = {
		function()
			return {
				exe = "forge",
				args = { "fmt", "--raw", "-" },
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
