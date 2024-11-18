local cmp_nvim_lsp = require("cmp_nvim_lsp")
local shellcheck = require("efmls-configs.linters.shellcheck")
local luacheck = require("efmls-configs.linters.luacheck")
local eslint = require("efmls-configs.linters.eslint")
local solhint = require("efmls-configs.linters.solhint")
local shfmt = require("efmls-configs.formatters.shfmt")
local stylua = require("efmls-configs.formatters.stylua")
local prettier_d = require("efmls-configs.formatters.prettier_d")
local forge_fmt = require("efmls-configs.formatters.forge_fmt")
local lspconfig = require("lspconfig")

local capabilities = cmp_nvim_lsp.default_capabilities()

lspconfig.bashls.setup({
	capabilities = capabilities,
	on_attach = require("lsp-format").on_attach,
	filetypes = { "sh" },
})

lspconfig.solidity_ls.setup({
	capabilities = capabilities,
	on_attach = require("lsp-format").on_attach,
	filetypes = { "solidity" },
	root_dir = lspconfig.util.root_pattern("foundry.toml", "hardhat.config.*", ".git"),
})

lspconfig.lua_ls.setup({
	capabilities = capabilities,
	on_attach = require("lsp-format").on_attach,
})

lspconfig.jsonls.setup({
	on_attach = require("lsp-format").on_attach,
	capabilities = capabilities,
	filetypes = { "json" },
})

lspconfig.ts_ls.setup({
	on_attach = require("lsp-format").on_attach,
	capabilities = capabilities,
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
})

local defaultLintFormat = { eslint, prettier_d }

lspconfig.efm.setup({
	on_attach = require("lsp-format").on_attach,
	filetypes = {
		"sh",
		"lua",
		"json",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"solidity",
		"html",
		"css",
		"markdown",
	},
	init_options = {
		documentFormatting = true,
		documentRangeFormatting = true,
		hover = true,
		documentSymbol = true,
		codeAction = true,
		completion = true,
	},
	settings = {
		languages = {
			sh = { shellcheck, shfmt },
			lua = { luacheck, stylua },
			json = defaultLintFormat,
			javascript = defaultLintFormat,
			javascriptreact = defaultLintFormat,
			typescript = defaultLintFormat,
			typescriptreact = defaultLintFormat,
			solidity = { solhint, forge_fmt },
			html = { prettier_d },
			css = { prettier_d },
			markdown = { prettier_d },
		},
	},
})

local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	group = lsp_fmt_group,
	callback = function()
		local efm = vim.lsp.get_clients({ name = "efm" })

		if vim.tbl_isempty(efm) then
			return
		end

		vim.lsp.buf.format({ name = "efm", async = true })
	end,
})
