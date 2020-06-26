local M = {}

local function setup_tree()
  vim.g.lua_tree_ignore = { '.git', 'node_modules' }
  vim.g.lua_tree_auto_open = 1
  vim.g.lua_tree_auto_close = 1
  vim.g.lua_tree_follow = 1
  vim.g.lua_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1
  }

  vim.api.nvim_set_keymap('n', '<C-n>', ':LuaTreeToggle<CR>', {
      noremap = true,
      silent = true
    })
  vim.api.nvim_set_keymap('n', '<leader>r', ':LuaTreeRefresh<CR>', {
      noremap = true,
      silent = true
    })

  vim.api.nvim_exec([[
  augroup LuaTreeOverride
    au!
    au FileType LuaTree setlocal nowrap
  augroup END
  ]], '')
end

local function setup_fzf()
  vim.g.fzf_layout = { down = '~25%' }
  vim.api.nvim_set_keymap('n', '<C-p>', ':Files<CR>', {
      noremap = true,
      silent = true
    })
  vim.api.nvim_set_keymap('n', '<leader>b', ':Buffers<CR>', {
      noremap = true,
      silent = true
    })
  vim.api.nvim_set_keymap('n', '<leader>p', ':Rg<CR>', {
      noremap = true,
      silent = true
    })

  vim.api.nvim_exec("command! -bang -nargs=* Rg"..
        " call fzf#vim#grep("..
        "'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,"..
        "fzf#vim#with_preview({'down': '50%'}), <bang>0)", '')
  vim.api.nvim_exec([[
    au FileType fzf set laststatus=0 noshowmode noruler nonumber norelativenumber]]..
    [[ | autocmd BufLeave <buffer> set laststatus=2 showmode ruler relativenumber
      ]], '')
end

function M.setup()
  setup_tree()
  setup_fzf()
end

return M
