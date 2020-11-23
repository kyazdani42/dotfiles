lua require 'init'
au FileType LuaTree lua vim.api.nvim_buf_set_keymap(0, 'n', '<C-p>', ':wincmd l | :Files<CR>', {})
au FileType LuaTree lua vim.api.nvim_buf_set_keymap(0, 'n', '<C-b>', ':wincmd l | :Buffers<CR>', {})
au FileType LuaTree lua vim.api.nvim_buf_set_keymap(0, 'n', '<C-t>', ':wincmd l | :RG<CR>', {})
