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

local function get_lua_runtime()
  local result = {};

  for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
    local lua_path = path .. "/lua/";
    if vim.fn.isdirectory(lua_path) then
      result[lua_path] = true
    end
  end

  result[vim.fn.expand("$VIMRUNTIME/lua")] = true
  result[vim.fn.expand("~/dev/nvim_dev/neovim/src/nvim/lua")] = true

  return result;
end

local function get_filetypes_config()
  return {
    { lsp_name = "bashls" },
    -- { lsp_name = "cssls" },
    { lsp_name = "gopls" },
    -- { lsp_name = "html" },
    -- { lsp_name = "jsonls" },
    -- { lsp_name = "rust_analyzer" },
    { lsp_name = "vimls" },
    {
      lsp_name = "sumneko_lua",
      lsp_settings = {
        Lua = {
          runtime = {version = "LuaJIT", path = vim.split(package.path, ';')},
          completion = { keywordSnippet = "Disable" },
          diagnostics = {
            globals = {"vim", "map", "filter", "range", "reduce", "head", "tail", "nth", "use"},
          },
          workspace = {
            library = get_lua_runtime()
          }
        }
      }
    },
    -- TSSERVER is borken with nvim-lsp
    -- {
    --   lsp_name = "tsserver",
    --   lsp_settings = {
    --     cmd = {"typescript-language-server", "--stdio"},
    --     filetypes = {
    --       "javascript",
    --       "javascriptreact",
    --       "javascript.jsx",
    --       "typescript",
    --       "typescriptreact",
    --       "typescript.tsx"
    --     },
    --   }
    -- },
    -- this still make neovim ask for 'override existing file...' and does not work
    -- {
    --   lsp_name = 'diagnosticls',
    --   lsp_settings = {
    --     filetypes = {
    --       "javascript",
    --       "javascriptreact",
    --       "javascript.jsx",
    --       "typescript",
    --       "typescriptreact",
    --       "typescript.tsx",
    --       "lua",
    --       "rust"
    --     }
    --   }
    -- }
  }
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


local function on_attach(client)
  require'completion'.on_attach(client)

  local mapper = require'utils'.mapper
  -- not working
  -- mapper('i', '<c-space>',  '<esc>:call completion#trigger_completion()<CR>')
  mapper('n', 'K',          '<cmd>lua require"lsp".show_doc()<CR>')
  mapper('n', '<leader>k',      '<cmd>lua require"lsp".hover()<CR>')

  mapper('n', 'gr',         '<cmd>lua vim.lsp.buf.references()<CR>')
  mapper('n', 'gd',         '<cmd>lua vim.lsp.buf.definition()<CR>')
  mapper('n', 'gy',         '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  mapper('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')

  mapper('n', '<leader>s',  '<cmd>lua require"lsp_cbs.diagnostics".prev()<CR>')
  mapper('n', '<leader>d',  '<cmd>lua require"lsp_cbs.diagnostics".next()<CR>')
end

local function location_cb(err, _, result)
  if err then return api.nvim_err_writeln(err) end
  if not result then
    return require'utils'.warn('No definition found')
  end

  local res = vim.tbl_islist(result) and result[1] or result
  vim.lsp.util.jump_to_location(res)
end

function M.setup()
  for name, value in pairs(opts) do
    api.nvim_set_option(name, value)
  end

  vim.lsp.callbacks['textDocument/definition'] = location_cb
  vim.lsp.callbacks['textDocument/references'] = require'lsp_cbs.references'.references_cb

  for _, lsp_config in ipairs(get_filetypes_config()) do
    if lsp_config.lsp_name then
      if lsp_config.lsp_settings then
        require'nvim_lsp'[lsp_config.lsp_name].setup{
            on_attach = on_attach,
            settings = lsp_config.lsp_settings,
          }
      else
        require'nvim_lsp'[lsp_config.lsp_name].setup{
            on_attach = on_attach,
          }
      end
    end
  end
end

return M
