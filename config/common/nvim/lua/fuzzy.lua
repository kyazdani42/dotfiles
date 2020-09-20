local a = vim.api
local fn = vim.fn
local luv = vim.loop

local M = {}

local bufnr = {
  results = 0,
  preview = 0,
  editable = 0,
  line = 0,
  previous = 0
}

local data = {}

function M.close()
  a.nvim_win_close(fn.bufwinid(bufnr.preview), true)
  a.nvim_win_close(fn.bufwinid(bufnr.results), true)
  a.nvim_win_close(fn.bufwinid(bufnr.line),    true)

  a.nvim_set_current_win(fn.bufwinid(bufnr.previous))
  vim.cmd "stopinsert"
end

local function update_fuzzy()
  local line = a.nvim_get_current_line()
  local lines = {}

  for _, l in ipairs(data) do
    if l:match(line) ~= nil then
      table.insert(lines, l)
    end
  end

  -- We have to defer because vim do not have time to save undo history otherwise.
  -- Damn lua you are fast.
  vim.defer_fn(function()
    a.nvim_buf_set_option(bufnr.results, 'modifiable', true)
    a.nvim_buf_set_lines(bufnr.results, 0, -1, false, lines)
    a.nvim_buf_set_option(bufnr.results, 'modifiable', false)
  end, 5)
end

function M.fuze(type)
  bufnr.previous = a.nvim_get_current_buf()

  if type == 'files' then
    data = vim.fn.systemlist('rg --files')
  elseif type == 'buffer' then
  elseif type == 'search' then
  end

  bufnr.results = require'utils.buf'.make_buffer {
    where = 'bottom',
    size = 30,
    lines = data,
    reset_keymaps = true,
    buf_options = {
      modifiable = false,
      buftype = 'nofile',
      bufhidden = 'wipe',
      swapfile = false,
    },
  }

  bufnr.preview = require'utils.buf'.make_buffer {
    where = 'preview',
    reset_keymaps = true,
    lines = {},
    buf_options = {
      modifiable = false,
      buftype = 'nofile',
      bufhidden = 'wipe',
      swapfile = false,
    }
  }
  a.nvim_set_current_win(fn.bufwinid(bufnr.results))

  bufnr.line = require'utils.buf'.make_buffer {
    where = 'bottom',
    reset_keymaps = true,
    size = 1,
    lines = {},
    keymaps = {
      { mode = 'i', l = '<esc>', cmd = '<cmd>lua require"fuzzy".close()<CR>' },
      { mode = 'i', l = '<C-p>', cmd = '' },
      { mode = 'i', l = '<C-k>', cmd = '' },
      { mode = 'i', l = '<C-n>', cmd = '' },
      { mode = 'i', l = '<C-j>', cmd = '' },
    },
    buf_options = {
      buftype = 'nofile',
      bufhidden = 'wipe',
      swapfile = false,
    }
  }

  a.nvim_buf_attach(bufnr.line, false, { on_lines = update_fuzzy })
  vim.cmd("echohl Directory | echo '"..luv.cwd():gsub(fn.expand('$HOME'), '~').."' | echohl Normal | set ft=fuzzy | startinsert")
end

function M.setup()
  vim.cmd "au FileType fuzzy set laststatus=0 | autocmd BufLeave <buffer> set laststatus=2"
  require'utils'.mapper('n', '<leader>e', '<cmd>lua require"fuzzy".fuze("files")<CR>')
end

return M
