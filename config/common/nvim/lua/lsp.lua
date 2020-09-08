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

local opts = {
  completeopt = 'menuone,noinsert,noselect',
  hidden = true,
  backup = false,
  writebackup = false,
  cmdheight = 2,
  updatetime = 300,
  signcolumn = 'yes',
}

local current_hovered_word = nil
function M.hover()
  local new_current_hovered_word = vim.fn.expand('<cword>')
  if current_hovered_word ~= new_current_hovered_word then
    vim.lsp.buf.hover()
  end
  current_hovered_word = new_current_hovered_word
end

local function on_attach()
  require'completion'.on_attach()
  require'diagnostic'.on_attach()
end

local function get_filetypes_config()
  return {
    { lsp_name = "bashls" },
    { lsp_name = "cssls" },
    { lsp_name = "gopls" },
    { lsp_name = "html" },
    { lsp_name = "jsonls" },
    { lsp_name = "rust_analyzer" },
    { lsp_name = "vimls" },
    {
      lsp_name = "sumneko_lua",
      lsp_settings = {
        Lua = {
          diagnostics = {
            globals = {"vim", "map", "filter", "range", "reduce", "head", "tail", "nth"},
            disable = {"redefined-local"}
          },
          runtime = {version = "LuaJIT"}
        }
      }
    },
    {
      lsp_name = "tsserver",
      lsp_settings = {
        cmd = {"typescript-language-server", "--stdio"},
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx"
        },
      }
    },
    -- TODO: diagnosticls fucks up i don't know why
    -- require'nvim_lsp'.diagnosticls.setup{}
  }
end

local function format_refs(references)
  local cwd = vim.loop.cwd()
  local formatted = {}

  for i, ref in ipairs(references) do
    local format_uri = string.gsub(ref.uri, cwd, ''):gsub('file:///', '')
    local range = ref.range
    local scol, sline, ecol, eline = range.start.character, range.start.line, range['end'].character, range['end'].line
    formatted[i] = format_uri.." ["..sline..", "..scol.."] -> ["..eline..", "..ecol.."] "
  end

  return formatted
end

function M.references()
  local params = vim.lsp.util.make_position_params()
  local result = vim.lsp.buf_request_sync(0, 'textDocument/references', params)
  if not result then return end

  vim.cmd('vnew | wincmd J | resize 10')
  local lines = format_refs(result[1].result)
  api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

function M.setup()
  for name, value in pairs(opts) do
    api.nvim_set_option(name, value)
  end

  vim.api.nvim_exec([[
    augroup NvimLspCmd
    autocmd CursorHold * lua require'lsp'.hover()
    augroup END
    ]], "")
  for _, lsp_config in ipairs(get_filetypes_config()) do
    if lsp_config.lsp_name then
      if lsp_config.lsp_settings then
        require'nvim_lsp'[lsp_config.lsp_name].setup{
          on_attach = on_attach,
          settings = lsp_config.lsp_settings
        }
      else
        require'nvim_lsp'[lsp_config.lsp_name].setup{
          on_attach = on_attach,
        }
      end
    end
  end

  vim.api.nvim_exec([[
    inoremap <silent><expr> <c-space> completion#trigger_completion()
    nnoremap <silent> K  :lua require'lsp'.show_doc()<CR>
    nnoremap <silent> gr :lua require'lsp'.references()<CR>

    nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> gy    <cmd>lua vim.lsp.buf.type_definition()<CR>

    nnoremap <silent> <leader>s <cmd>PrevDiagnosticCycle<CR>
    nnoremap <silent> <leader>d <cmd>NextDiagnosticCycle<CR>
    ]], '')
end

return M
