local vim = vim
local api = vim.api
local M = {}
function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

M.map("n", "<esc>", ":noh<cr>")

M.map("n", "gd", "<cmd> lua vim.lsp.buf.definition()<cr>")
M.map("n", "gr", "<cmd> lua vim.lsp.buf.references()<cr>")

M.map("n", "K", ":Lspsaga hover_doc<cr>")
M.map("n", "[[", ":Lspsaga diagnostic_jump_next<cr>")
M.map("n", "]]", ":Lspsaga diagnostic_jump_prev<cr>")
M.map("n", "<leader>rn", ":Lspsaga rename<cr>")
M.map("n", "<leader>cf", ":Lspsaga code_action<cr>")

M.map("n", "<leader>w<space>", "<cmd>:w<cr>")
M.map("n", "<leader>q", "<cmd>:q<cr>")
M.map("n", "<leader>wq", "<cmd>:wq<cr>")

M.map("n", "<leader>ff", "<cmd>lua require('my.telescope').find_files()<cr>")
M.map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")

M.map("n", "<Leader>t", ":NvimTreeFindFile<CR>")

M.map("n", "<leader>f", ":Format<cr>")

M.map("n", "<leader>cc", "<Plug>kommentary_line_default", { noremap = false })
M.map("n", "<leader>c", "<Plug>kommentary_motion_default", { noremap = false })
M.map("x", "<leader>c", "<Plug>kommentary_visual_default", { noremap = false })

M.map("n", "<leader>ht", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>")
M.map("n", "<leader>hm", "<cmd>lua require('harpoon.mark').add_file()<cr>")
M.map("n", "<leader>hh", "<cmd>lua require('harpoon.ui').nav_prev()<cr>")
M.map("n", "<leader>hl", "<cmd>lua require('harpoon.ui').nav_next()<cr>")

return M
