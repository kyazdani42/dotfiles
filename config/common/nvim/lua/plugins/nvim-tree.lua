function _G.move_or_open()
	if #vim.api.nvim_list_wins() == 1 then
		vim.cmd("vnew | wincmd h | vert resize 30 | wincmd l")
	else
		vim.cmd("wincmd l")
	end
end

vim.g.nvim_tree_ignore = { '.git', 'node_modules', 'dist' }
vim.g.nvim_tree_auto_open = 1
vim.g.nvim_tree_auto_close = 0
vim.g.nvim_tree_disable_netrw = 0
vim.g.nvim_tree_hijack_netrw = 1
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_tab_open = 1
vim.g.nvim_tree_lint_lsp = 1
vim.g.nvim_tree_gitignore = 1
vim.g.nvim_tree_show_icons = {
	git = 1,
	folders = 1,
	files = 1
}
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_lsp_diagnostics = 1

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
