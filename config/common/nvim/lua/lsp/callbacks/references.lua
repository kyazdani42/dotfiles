local api = vim.api
local M = {}

local function format_refs(references)
  local cwd = vim.loop.cwd()
  local formatted = {}

  for i, ref in ipairs(references) do
    local format_uri = string.gsub(ref.uri, cwd, ''):gsub('file:///', '')
    local range = ref.range
    local sline = range.start.line+1
    formatted[i] = format_uri.." l."..sline
  end

  return formatted
end

local main_buf = 0
local main_win = 0
local preview_bufnr = 0
local ref_bufnr = 0

function M.preview_ref(type)
  if type then
    api.nvim_exec("normal g"..type, "")
  end
  local line = vim.split(api.nvim_get_current_line(), ' ')
  local file = line[1]
  local line_nb = line[2]:sub(3)
  local ok, f = pcall(vim.fn.readfile, file)
  if not ok then
    f = vim.fn.readfile('/'..file)
  end
  api.nvim_buf_set_option(preview_bufnr, 'modifiable', true)
  api.nvim_buf_set_lines(preview_bufnr, 0, -1, false, f)
  api.nvim_win_set_cursor(vim.fn.bufwinid(preview_bufnr), { tonumber(line_nb), 0 })
  api.nvim_buf_set_option(preview_bufnr, 'modifiable', false)
end

function M.close()
  api.nvim_win_close(vim.fn.bufwinid(preview_bufnr), true)
  api.nvim_win_close(vim.fn.bufwinid(ref_bufnr), true)
  vim.cmd "set laststatus=2"
  api.nvim_set_current_win(main_win)
end

function M.select_from_ref()
  local line = vim.split(api.nvim_get_current_line(), ' ')
  local file = line[1]
  local line_nb = vim.split(line[2], '%.')[2]
  M.close()
  vim.cmd("e "..file)
  api.nvim_win_set_cursor(main_win, { [1] = tonumber(line_nb), [2] = 0})
end

function M.references_cb(err, _, results)
  if err then return api.nvim_err_writeln(err) end
  if not results or #results < 2 then
    return require'utils'.warn("No reference found")
  end

  main_buf = api.nvim_get_current_buf()
  main_win = api.nvim_get_current_win()

  ref_bufnr = require'utils.buf'.make_buffer {
    where = 'bottom',
    size = 15,
    lines = format_refs(results),
    reset_keymaps = true,
    keymaps = {
      { mode = 'n', l = 'j', cmd = '<cmd>lua require"lsp.callbacks.references".preview_ref("j")<CR>' },
      { mode = 'n', l = 'k', cmd = '<cmd>lua require"lsp.callbacks.references".preview_ref("k")<CR>' },
      { mode = 'n', l = '<CR>', cmd = '<cmd>lua require"lsp.callbacks.references".select_from_ref()<CR>' },
      { mode = 'n', l = 'q', cmd = '<cmd>lua require"lsp.callbacks.references".close()<CR>' },
      { mode = 'n', l = '<esc>', cmd = '<cmd>lua require"lsp.callbacks.references".close()<CR>' },
      { mode = 'n', l = '<C-c>', cmd = '<cmd>lua require"lsp.callbacks.references".close()<CR>' },
      { mode = 'n', l = '<C-j>', cmd = '<cmd>lua require"lsp.callbacks.references".close()<CR>' },
    },
    win_options = {
      wrap = false
    },
    buf_options = {
      modifiable = false,
      buftype = 'nofile',
      bufhidden = 'wipe',
      swapfile = false,
    },
  }

  vim.cmd "set laststatus=0"

  preview_bufnr = require'utils.buf'.make_buffer {
    where = 'preview',
    reset_keymaps = true,
    lines = {},
    buf_options = {
      modifiable = false,
      buftype = 'nofile',
      bufhidden = 'wipe',
      swapfile = false
    }
  }

  local filetype = api.nvim_buf_get_option(main_buf, 'ft')
  vim.cmd('set ft='..filetype..' | wincmd h')

  M.preview_ref()
end

return M
