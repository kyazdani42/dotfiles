local api = vim.api

local M = {}

local keymaps = {
  { mod = '', lhs = '<C-j>', rhs = '', opt = {nowait = true} },
  { mod = 'i', lhs = '<C-j>', rhs = '<Esc>' },
  { mod = 'v', lhs = '<C-j>', rhs = '<Esc>' },

  { mod = 'n', lhs = '<C-j>', rhs = '<C-w>j' },
  { mod = 'n', lhs = '<C-k>', rhs = '<C-w>k' },
  { mod = 'n', lhs = '<C-l>', rhs = '<C-w>l' },
  { mod = 'n', lhs = '<C-h>', rhs = '<C-w>h' },

  { mod = 'n', lhs = 'j', rhs = 'gj' },
  { mod = 'n', lhs = 'k', rhs = 'gk' },
  { mod = 'n', lhs = '<leader><leader>', rhs = '<c-^>' },

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
  { mod = 'n', lhs = '<tab>', rhs = ':normal za<cr>', opt = { noremap = true, silent = true }}
}

function M.setup()
    local default_opt = { nowait = true, noremap = true }

    api.nvim_command('cabbrev W w')

    for _, keymap in pairs(keymaps) do
      api.nvim_set_keymap(keymap.mod, keymap.lhs, keymap.rhs, keymap.opt or default_opt)
    end

    require 'colorizer'.setup()
    require 'statusline'.setup()
    require 'ts'.setup()
end

return M
