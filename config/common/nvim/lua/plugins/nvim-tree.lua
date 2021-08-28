vim.g.nvim_tree_ignore = { '.git', 'node_modules', 'dist' }
vim.g.nvim_tree_auto_open = 1
vim.g.nvim_tree_auto_close = 0
vim.g.nvim_tree_disable_netrw = 0
vim.g.nvim_tree_hijack_netrw = 1
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_tab_open = 1
vim.g.nvim_tree_lint_lsp = 1
vim.g.nvim_tree_gitignore = 1
vim.g.nvim_tree_update_cwd = 1
vim.g.nvim_tree_show_icons = {
	git = 1,
	folders = 1,
	files = 1,
  folder_arrows = 1
}
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_lsp_diagnostics = 1
vim.g.nvim_tree_hijack_cursor = 1
vim.g.nvim_tree_window_picker_exclude = {
  filetype = {
    "packer",
    "qf",
    "Trouble"
  }
}

vim.g.nvim_tree_icons = {
	default = '',
	git= {
		unstaged = "✗",
		staged = "✓",
		unmerged = "",
		renamed = "➜",
		untracked = "★"
	},
	folder = {
		default = "",
		open = ""
	}
}

vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', {
	noremap = true,
	silent = true
})

vim.api.nvim_set_keymap('n', '<leader>r', ':NvimTreeRefresh<CR>', {
	noremap = true,
	silent = true
})
