local api = vim.api
local M = {}

function M.show_doc()
  local ft = api.nvim_buf_get_option(api.nvim_get_current_buf(), 'ft')
  if ft == 'vim' or ft == 'help' then
    vim.api.nvim_exec('h '..vim.fn.expand('<cword>'), '')
  else
    api.nvim_call_function("CocAction('doHover')")
  end
end

local opts = {
  completeopt = 'menuone,noinsert,noselect',
  hidden = true,
  backup = false,
  writebackup = false,
  cmdheight = 2,
  updatetime = 300,
  signcolumn = 'yes',
}

function M.setup()
  for name, value in pairs(opts) do
    api.nvim_set_option(name, value)
  end

  vim.api.nvim_exec([[
    inoremap <silent><expr> <c-space> coc#refresh()
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    nmap <silent> <leader>j <Plug>(coc-diagnostic-prev)
    nmap <silent> <leader>k <Plug>(coc-diagnostic-next)
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gr <Plug>(coc-references)
    nmap <leader>rn  <Plug>(coc-rename)
    nnoremap <silent> K :lua require'lsp'.show_doc()<CR>
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    command! -nargs=0 Format :call CocAction('format')
    ]], '')
end

return M
