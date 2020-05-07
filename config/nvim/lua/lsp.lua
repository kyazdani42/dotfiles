local api = vim.api
local lsp = require'nvim_lsp'
local lsp_comp = require'completion'
local lsp_diagnostic = require'diagnostic'
local M = {}

local keymaps = {
  {
    mod = 'i',
    lhs = '<C-p>',
    rhs = 'completion#trigger_completion()',
    opt = { noremap = true, silent = true, expr = true }
  },
  {
    mod = 'i',
    lhs = '<C-n>',
    rhs = 'completion#trigger_completion()',
    opt = { noremap = true, silent = true, expr = true }
  },
  {
    mod = 'n',
    lhs = 'gd',
    rhs = '<cmd>lua vim.lsp.buf.definition()<CR>',
    opt = { noremap = true, silent = true }
  },
  {
    mod = 'n',
    lhs = '<leader>gd',
    rhs = '<cmd>lua vim.lsp.buf.declaration()<CR>',
    opt = { noremap = true, silent = true }
  },
  {
    mod = 'n',
    lhs = 'K',
    rhs = '<cmd>lua vim.lsp.buf.hover()<CR>',
    opt = { noremap = true, silent = true }
  },
  {
    mod = 'n',
    lhs = 'gr',
    rhs = '<cmd>lua vim.lsp.buf.references()<CR>',
    opt = { noremap = true, silent = true }
  },
  -- nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
  -- nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
  -- nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
  -- nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
  {
    mod = 'n',
    lhs = '<leader>j',
    rhs = ':PrevDiagnosticCycle<cr>',
    opt = { noremap = true, silent = true }
  },
  {
    mod = 'n',
    lhs = '<leader>k',
    rhs = ':NextDiagnosticCycle<cr>',
    opt = { noremap = true, silent = true }
  }
}

function M.setup()
  lsp.sumneko_lua.setup {
    on_attach = function()
      lsp_comp.on_attach()
      lsp_diagnostic.on_attach()
    end
  }

  lsp.rust_analyzer.setup {
    on_attach = lsp_comp.on_attach,
    serverPath = "/usr/bin/rust-analyzer"
  }

  api.nvim_set_option('completeopt', 'menuone,noinsert,noselect')
  api.nvim_set_var('diagnostic_enable_virtual_text', 0)
  api.nvim_set_var('diagnostic_show_sign', 0)
  api.nvim_set_var('diagnostic_insert_delay', 1)

  for _, keymap in pairs(keymaps) do
    api.nvim_set_keymap(keymap.mod, keymap.lhs, keymap.rhs, keymap.opt)
  end
end

return M
