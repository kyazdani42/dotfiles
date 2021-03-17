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
end

local function location_cb(err, _, result)
  if err then return api.nvim_err_writeln(err) end
  if not result then
    return require'utils'.warn('No definition found')
  end

  local res = vim.tbl_islist(result) and result[1] or result
  vim.lsp.util.jump_to_location(res)
end

local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}

local function eslint_config_exists()
  local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)

  if not vim.tbl_isempty(eslintrc) then
    return true
  end

  if vim.fn.filereadable("package.json") then
    if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
      return true
    end
  end

  return false
end

local function efm()
  require "lspconfig".efm.setup {
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.goto_definition = false
  end,
  root_dir = function()
    if not eslint_config_exists() then
      return nil
    end
    return vim.fn.getcwd()
  end,
  settings = {
    languages = {
      javascript = {eslint},
      javascriptreact = {eslint},
      ["javascript.jsx"] = {eslint},
      typescript = {eslint},
      ["typescript.tsx"] = {eslint},
      typescriptreact = {eslint}
    }
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescript.tsx",
    "typescriptreact"
  },
}

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
    on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false
      on_attach(client, bufnr)
    end,
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
  efm()
end

return M
