local api = vim.api
local nvim_lsp = require'nvim_lsp'

local function set_keymaps()
    api.nvim_command('nnoremap <silent> K           <cmd>lua vim.lsp.buf.hover()<CR>')
    api.nvim_command('nnoremap <silent> <leader>k   <cmd>lua vim.lsp.buf.signature_help()<CR>')
    api.nvim_command('nnoremap <silent> gd          <cmd>lua vim.lsp.buf.declaration()<CR>')
    api.nvim_command('nnoremap <silent> gD          <cmd>lua vim.lsp.buf.implementation()<CR>')
    api.nvim_command('nnoremap <silent> 1gD         <cmd>lua vim.lsp.buf.type_definition()<CR>')
    api.nvim_command('nnoremap <silent> gr          <cmd>lua vim.lsp.buf.references()<CR>')
    api.nvim_command('nnoremap <silent> <C-]>       <cmd>lua vim.lsp.buf.definition()<CR>')
end

local function setup()
    nvim_lsp.vimls.setup{}
    nvim_lsp.bashls.setup{}
    nvim_lsp.tsserver.setup{}
    nvim_lsp.sumneko_lua.setup{}
    set_keymaps()
end

return {
    setup = setup
}
