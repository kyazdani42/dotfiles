local M = {}

function M.setup()
  vim.g.nvim_tree_ignore = { '.git', 'node_modules', 'dist' }
  vim.g.nvim_tree_auto_open = 1
  vim.g.nvim_tree_auto_close = 0
  vim.g.nvim_tree_follow = 1
  vim.g.nvim_tree_tab_open = 1
  vim.g.nvim_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1
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

  vim.g.nvim_tree_bindings = {
    preview = { '<Tab>' }
  }

  vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', {
      noremap = true,
      silent = true
    })
  vim.api.nvim_set_keymap('n', '<leader>r', ':NvimTreeRefresh<CR>', {
      noremap = true,
      silent = true
    })
end

return M
