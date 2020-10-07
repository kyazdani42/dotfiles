require 'plugins'

local keymaps = {
  { mod = '', lhs = '<C-j>', rhs = '', opt = {nowait = true} },
  { mod = 'i', lhs = '<C-j>', rhs = '<Esc>' },
  { mod = 'v', lhs = '<C-j>', rhs = '<Esc>' },

  { mod = 'n', lhs = '<C-j>', rhs = '<C-w>j' },
  { mod = 'n', lhs = '<C-k>', rhs = '<C-w>k' },
  { mod = 'n', lhs = '<C-l>', rhs = '<C-w>l' },
  { mod = 'n', lhs = '<C-h>', rhs = '<C-w>h' },

  { mod = 'n', lhs = '<leader>v', rhs = ':noh<CR>', opt = {silent=true} },

  { mod = 'n', lhs = 'j', rhs = 'gj' },
  { mod = 'n', lhs = 'k', rhs = 'gk' },
  { mod = 'n', lhs = '<space><space>', rhs = '<c-^>' },
  { mod = 'n', lhs = '<leader><leader>', rhs = ':tabnext<CR>' },

  { mod = 'n', lhs = 'Q', rhs = '' },
  { mod = 'n', lhs = '<F1>', rhs = '' },
  { mod = 'i', lhs = '<F1>', rhs = '' },

  { mod = 'n', lhs = '<C-u>', rhs = '<C-u>zz' },
  { mod = 'n', lhs = '<C-d>', rhs = '<C-d>zz' },
  { mod = 'n', lhs = '<C-f>', rhs = '<C-f>zz' },
  { mod = 'n', lhs = '(', rhs = '(zz' },
  { mod = 'n', lhs = ')', rhs = ')zz' },
  { mod = 'v', lhs = '(', rhs = '(zz' },
  { mod = 'v', lhs = ')', rhs = ')zz' },

  -- Ctrl + / is outputing ++ (term configuration)
  { mod = 'n', lhs = '++', rhs = ':TComment<cr>', opt = { silent = true } },
  { mod = 'v', lhs = '++', rhs = ':TComment<cr>', opt = { silent = true } },
  { mod = 'n', lhs = '<tab>', rhs = ':normal za<cr>', opt = { noremap = true, silent = true }},

  -- TODO: find a way to map that but not on fzf
  -- { mod = 't', lhs = '<C-k>', rhs = '<C-\\><C-n>', opt = { noremap = true } },
  { mod = 't', lhs = '<C-w>h', rhs = '<C-\\><C-n><c-w>h', opt = { noremap = true } },
  { mod = 't', lhs = '<C-w>j', rhs = '<C-\\><C-n><c-w>j', opt = { noremap = true } },
  { mod = 't', lhs = '<C-w>k', rhs = '<C-\\><C-n><c-w>k', opt = { noremap = true } },
  { mod = 't', lhs = '<C-w>l', rhs = '<C-\\><C-n><c-w>l', opt = { noremap = true } },
}

local default_opt = { nowait = true, noremap = true }

vim.api.nvim_exec([[
  cabbrev W w
  cabbrev terminal vsplit term://zsh
  cabbrev term vsplit term://zsh
  autocmd TermOpen * startinsert
  ]], '')

for _, keymap in pairs(keymaps) do
  vim.api.nvim_set_keymap(keymap.mod, keymap.lhs, keymap.rhs, keymap.opt or default_opt)
end

require 'statusline'.setup()
require 'formatter'.setup()
require 'fuzzy'.setup()
-- require 'nvim-github'.setup()
