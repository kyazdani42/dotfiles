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
