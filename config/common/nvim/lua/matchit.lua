local a = vim.api
local ts = require'nvim-treesitter.ts_utils'
local tslocals = require'nvim-treesitter.locals'
local M = {}

-- matchit based on treesitter (experiment)
function _G.tsMatchit()
  local node = tslocals.containing_scope(ts.get_node_at_cursor(0), 0, true)
  local _, lnum, col = unpack(vim.fn.getcurpos())
  lnum = lnum - 1
  col = col - 1
  local srow, scol, erow, ecol = node:range()

  if lnum - srow < erow - lnum then
    a.nvim_win_set_cursor(0, {erow+1, ecol})
  else
    a.nvim_win_set_cursor(0, {srow+1, scol})
  end
end

function M.setup()
  a.nvim_buf_set_keymap(0, 'n', '%', ':lua tsMatchit()<CR>', {silent=true})
end

return M
