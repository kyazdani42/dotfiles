local M = {}

local function setup_tree()
  vim.g.lua_tree_ignore = { '.git', 'node_modules' }
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
    preview = { '<C-p>', '<C-b>', '<Tab>' }
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
  vim.api.nvim_set_keymap('n', '<C-b>', ':Buffers<CR>', {
      noremap = true,
      silent = true
    })
  vim.api.nvim_set_keymap('n', '<C-t>', ':RG<CR>', {
      noremap = true,
      silent = true
    })

  vim.api.nvim_exec([[
    function! RipgrepFzf(query)
          let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
          let initial_command = printf(command_fmt, shellescape(a:query))
          let reload_command = printf(command_fmt, '{q}')
          let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command], 'down': '70%'}
          call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec))
        endfunction

        command! -nargs=* -bang RG call RipgrepFzf(<q-args>)
        au FileType fzf set laststatus=0 noshowmode noruler nonumber norelativenumber | autocmd BufLeave <buffer> set laststatus=2 showmode ruler relativenumber
      ]], '')
end

function M.setup()
  setup_tree()
  setup_fzf()
  vim.g.EditorConfig_exclude_patterns = {'fugitive://.*', 'scp://.*'}
  vim.g.vim_markdown_folding_disabled = 1
end

return M
