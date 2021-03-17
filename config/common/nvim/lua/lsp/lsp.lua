local api = vim.api
local M = {}

function M.show_doc()
  local ft = api.nvim_buf_get_option(api.nvim_get_current_buf(), 'ft')
  if ft == 'vim' or ft == 'help' then
    vim.api.nvim_exec('h '..vim.fn.expand('<cword>'), '')
  else
    vim.lsp.buf.signature_help()
  end
end

local current_hovered_word = nil
function M.hover()
  local new_current_hovered_word = vim.fn.expand('<cword>')
  if current_hovered_word ~= new_current_hovered_word then
    vim.lsp.buf.hover()
  end
  current_hovered_word = new_current_hovered_word
end

local function on_attach(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local opts = { noremap=true, silent=true }
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  buf_set_keymap('n', 'K',              '<cmd>lua require"lsp.lsp".show_doc()<CR>', opts)
  buf_set_keymap('n', '<leader>k',      '<cmd>lua require"lsp.lsp".hover()<CR>', opts)

  buf_set_keymap('n', 'gr',         '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gd',         '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gy',         '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gi',         '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

  buf_set_keymap('n', '<leader>s',  '<cmd>lua require"lsp.callbacks.diagnostics".prev()<CR>', opts)
  buf_set_keymap('n', '<leader>d',  '<cmd>lua require"lsp.callbacks.diagnostics".next()<CR>', opts)

  -- if client.resolved_capabilities.document_formatting then
    -- buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  -- elseif client.resolved_capabilities.document_range_formatting then
    -- buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  -- end

  -- Set autocommands conditional on server_capabilities
  -- if client.resolved_capabilities.document_highlight then
    -- vim.api.nvim_exec([[
      -- hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      -- hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      -- hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      -- augroup lsp_document_highlight
        -- autocmd! * <buffer>
        -- autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        -- autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      -- augroup END
    -- ]], false)
  -- end
end

local function location_cb(err, _, result)
  if err then return api.nvim_err_writeln(err) end
  if not result then
    return require'utils'.warn('No definition found')
  end

  local res = vim.tbl_islist(result) and result[1] or result
  vim.lsp.util.jump_to_location(res)
end

local function sumneko(cap)
  local luapath = vim.fn.stdpath('cache')..'/lspconfigs/sumneko_lua'
  local luabin = luapath..'/bin/Linux/lua-language-server'
  require'lspconfig'.sumneko_lua.setup {
    cmd = { luabin, '-E', luapath..'/main.lua'},
    on_attach = on_attach,
    settings =  {
      Lua = {
        runtime = {
          version = "LuaJIT",
          path = vim.split(package.path, ';')
        },
        completion = { keywordSnippet = "Disable" },
        diagnostics = {
          globals = {"vim", "map", "filter", "range", "reduce", "head", "tail", "nth", "use"},
        },
        workspace = {
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          }
        }
      },
    },
    capabilities = cap,
  }
end

local function tsserver(cap)
  require'lspconfig'.tsserver.setup {
    capabilities = cap,
    on_attach = on_attach,
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  }
end

function M.setup()
  vim.lsp.handlers['textDocument/definition'] = location_cb
  vim.lsp.handlers['textDocument/references'] = require'lsp.callbacks.references'.references_cb

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  sumneko(capabilities)
  tsserver(capabilities)
end

return M
