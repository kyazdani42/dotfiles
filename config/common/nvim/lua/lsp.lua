local api = vim.api
local M = {}

function M.show_doc()
  local ft = api.nvim_buf_get_option(api.nvim_get_current_buf(), 'ft')
  if ft == 'vim' or ft == 'help' then
    vim.api.nvim_exec('h '..vim.fn.expand('<cword>'), '')
  else
    api.nvim_call_function("CocAction", {'doHover'})
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

local function fmt(bufnr, cmd)
  bufnr = bufnr or api.nvim_get_current_buf()
  local current_file = api.nvim_buf_get_name(bufnr)
  local stdout = vim.fn.system(cmd..current_file)
  local as_lines = vim.fn.split(stdout, '\n')
  table.remove(as_lines, 1)
  table.remove(as_lines, 1)
  local cursor = api.nvim_win_get_cursor(0)
  api.nvim_buf_set_lines(bufnr, 0, -1, false, as_lines)
  api.nvim_exec('w','')
  api.nvim_win_set_cursor(0, cursor)
end

function M.format()
  local bufnr = api.nvim_get_current_buf()
  local ft = api.nvim_buf_get_option(bufnr, 'ft')
  if ft == 'javascript' or ft == 'javascriptreact' then
    api.nvim_exec('CocCommand eslint.executeAutofix', '')
  elseif ft == 'rust' then
    fmt(bufnr, 'rustfmt --emit stdout ')
  else
    api.nvim_call_function("CocAction", {'format'})
  end
end

function M.setup()
  for name, value in pairs(opts) do
    api.nvim_set_option(name, value)
  end

  vim.api.nvim_exec([[
    inoremap <silent><expr> <c-space> coc#refresh()
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    nmap <silent> <leader>s <Plug>(coc-diagnostic-prev)
    nmap <silent> <leader>d <Plug>(coc-diagnostic-next)
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gr <Plug>(coc-references)
    nnoremap <silent> K :lua require'lsp'.show_doc()<CR>
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    command! -nargs=0 Eslint :CocAction('eslint.executeAutoFix')<CR>
    command! -nargs=0 Format :lua require'lsp'.format()<CR>
    ]], '')
end

return M
