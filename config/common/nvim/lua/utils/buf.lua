local api = vim.api

local M = {}

local function mapper(mode, key, result)
  api.nvim_buf_set_keymap(0, mode, key, result, { noremap = true, silent = true })
end

local function get_all_mappings()
  local buf = api.nvim_buf_get_keymap(0, 'n')
  local global = api.nvim_get_keymap('n')
  local others = {
    { lhs = 'l' },
    { lhs = 'h' },
    { lhs = 'j' },
    { lhs = 'k' },
    { lhs = '<c-w>j' },
    { lhs = '<c-w>h' },
    { lhs = '<c-w>k' },
    { lhs = '<c-w>l' },
    { lhs = '<c-o>' },
    { lhs = '<c-]>' },
  }

  return vim.tbl_extend('force', buf, global, others)
end

function M.make_buffer(options)
  local where = options.where or "bottom"
  local size = options.size or 10
  local lines = options.lines or {}
  local keymaps = options.keymaps or {}
  local buf_options = options.buf_options or {}
  local with_keymap_reset_all = options.reset_keymaps

  if where == 'bottom' then
    vim.cmd('vnew | wincmd J | resize '..size)
  elseif where == 'top' then
    vim.cmd('vnew | wincmd K | resize '..size)
  elseif where == 'left' then
    vim.cmd('vnew | wincmd H | resize '..size)
  elseif where == 'right' then
    vim.cmd('vnew | wincmd L | resize '..size)
  elseif where == 'preview' then
    vim.cmd('vnew')
  else
    return
  end

  api.nvim_buf_set_lines(0, 0, -1, false ,lines)
  for opt, value in pairs(buf_options) do
    api.nvim_buf_set_option(0, opt, value)
  end

  if with_keymap_reset_all then
    for _, keymap in ipairs(get_all_mappings()) do
      mapper('n', keymap.lhs, '')
    end
  end

  for _, keymap in ipairs(keymaps) do
    mapper(keymap.mode, keymap.l, keymap.cmd)
  end

  return api.nvim_get_current_buf()
end

return M
