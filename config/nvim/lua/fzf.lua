local api = vim.api

local function setup()
    api.nvim_set_var('fzf_preview_command', 'bat --decorations never --theme=ansi-dark --color=always --style=grid {-1}')
    api.nvim_set_var('fzf_preview_filelist_command', 'rg --files --hidden --follow --no-messages -g \\!"* *"')
    api.nvim_set_var('fzf_preview_preview_key_bindings', 'ctrl-f:preview-page-down,ctrl-u:preview-page-up,?:toggle-preview')

    local opts = { nowait = true, noremap = true, silent = true }
    api.nvim_set_keymap('n', '<C-p>', ':FzfPreviewDirectoryFiles<CR>', opts)
    api.nvim_set_keymap('n', '<leader>b', ':FzfPreviewBuffers<CR>', opts)
    api.nvim_set_keymap('n', '<leader>f', ':FzfPreviewProjectGrep<CR>', opts)
end

return {
    setup = setup
}
