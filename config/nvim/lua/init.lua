local api = vim.api

local function set_mappings()
    local default_opt = { nowait = true, noremap = true }

    api.nvim_set_keymap('', '<C-j>', '', { nowait = true })
    api.nvim_set_keymap('i', '<C-j>', '<Esc>', default_opt)
    api.nvim_set_keymap('v', '<C-j>', '<Esc>', default_opt)

    api.nvim_set_keymap('n', '<C-j>', '<C-w>j', default_opt)
    api.nvim_set_keymap('n', '<C-k>', '<C-w>k', default_opt)
    api.nvim_set_keymap('n', '<C-l>', '<C-w>l', default_opt)
    api.nvim_set_keymap('n', '<C-h>', '<C-w>h', default_opt)
    api.nvim_set_keymap('n', 'j', 'gj', default_opt)
    api.nvim_set_keymap('n', 'k', 'gk', default_opt)
    api.nvim_set_keymap('n', '<leader><leader>', '<c-^> ', default_opt)

    api.nvim_set_keymap('n', 'Q', '', default_opt)
    api.nvim_set_keymap('n', '<F1>', '', default_opt)
    api.nvim_set_keymap('i', '<F1>', '', default_opt)

    api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', default_opt)
    api.nvim_set_keymap('n', '<C-d>', '<C-d>zz', default_opt)
    api.nvim_set_keymap('n', '<C-f>', '<C-f>zz', default_opt)
    api.nvim_set_keymap('n', '{', '{zz', default_opt)
    api.nvim_set_keymap('n', '}', '}zz', default_opt)
    api.nvim_set_keymap('n', '(', '(zz', default_opt)
    api.nvim_set_keymap('n', ')', ')zz', default_opt)
    api.nvim_set_keymap('n', '[[', '[[zz', default_opt)
    api.nvim_set_keymap('n', '][', '][zz', default_opt)
    api.nvim_set_keymap('n', '[]', '[]zz', default_opt)
    api.nvim_set_keymap('n', '%', '%zz', default_opt)
    api.nvim_set_keymap('v', '{', '{zz', default_opt)
    api.nvim_set_keymap('v', '}', '}zz', default_opt)
    api.nvim_set_keymap('v', '(', '(zz', default_opt)
    api.nvim_set_keymap('v', ')', ')zz', default_opt)
    api.nvim_set_keymap('v', '[[', '[[zz', default_opt)
    api.nvim_set_keymap('v', '][', '][zz', default_opt)
    api.nvim_set_keymap('v', '[]', '[]zz', default_opt)
    api.nvim_set_keymap('v', '%', '%zz', default_opt)
    
    api.nvim_command('cabbrev W w')
end

local function setup()
    set_mappings()
end

return {
    setup = setup
}
