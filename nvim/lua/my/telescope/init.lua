local vim = vim
local telescope = require("telescope")
local builtIn = require("telescope.builtin")
local actions = require("telescope.actions")
local M = {}

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<Tab>"] = actions.toggle_selection,
      },
    },
  },
})

telescope.load_extension("fzf")

local function generateOpts(opts)
  local common_opts = {
    layout_strategy = "center",
    sorting_strategy = "ascending",
    results_title = false,
    preview_title = "Preview",
    previewer = false,
    layout_config = {
      width = 80,
      height = 15,
    },
    borderchars = {
      { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
  }
  return vim.tbl_extend("force", opts, common_opts)
end

function M.find_files()
  local cmn_opts = generateOpts({})
  builtIn.find_files(cmn_opts)
end

function M.help_tags()
  local opts = generateOpts({})
  builtIn.help_tags(opts)
end

return M
