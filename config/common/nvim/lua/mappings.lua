local function map(mod, lhs, rhs, opt)
  vim.api.nvim_set_keymap(mod, lhs, rhs, opt or {})
end

vim.g.mapleader = '\\'

map('', '<C-j>', '', { nowait = true })
map('i', '<C-j>', '<ESC>', { nowait = true })
map('v', '<C-j>', '<ESC>', { nowait = true })

map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')
map('n', '<C-h>', '<C-w>h')

map('n', '<leader>v', ':noh<CR>', { silent=true })

map('n', 'j', 'gj')
map('n', 'k', 'gk')
map('n', '<space><space>', '<c-^>')
map('n', '<leader><leader>', ':tabnext<CR>')

map('n', 'Q', '')
map('n', '<F1>', '')
map('i', '<F1>', '')

map('n', '<C-u>', '<C-u>zz')
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-f>', '<C-f>zz')

map('n', '<tab>', ':normal za<cr>', { noremap = true, silent = true })

map('n', '<leader>b', ':BufferLinePick<cr>', { silent = true })
