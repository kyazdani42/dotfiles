local M = {}

function M.setup()
  vim.g.lua_tree_ignore = { '.git', 'node_modules', 'dist' }
  vim.g.lua_tree_auto_open = 1
  vim.g.lua_tree_auto_close = 0
  vim.g.lua_tree_follow = 1
  vim.g.lua_tree_tab_open = 1
  vim.g.lua_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1
  }

  vim.g.lua_tree_icons = {
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

  vim.g.lua_tree_bindings = {
    preview = { '<Tab>' }
  }

  vim.api.nvim_set_keymap('n', '<C-n>', ':LuaTreeToggle<CR>', {
      noremap = true,
      silent = true
    })
  vim.api.nvim_set_keymap('n', '<leader>r', ':LuaTreeRefresh<CR>', {
      noremap = true,
      silent = true
    })
end

return M
