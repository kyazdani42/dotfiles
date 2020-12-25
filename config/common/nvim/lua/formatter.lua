local api = vim.api
local M = {}

local function has_ex(ex)
  return vim.fn.executable(ex) == 1
end

local function save()
  vim.cmd('w!')
end

local function prettier_fmt()
  save()
  local bufnr = api.nvim_get_current_buf();
  local current_file = api.nvim_buf_get_name(bufnr)

  if has_ex('prettier') then
    local formatted = vim.split(vim.fn.system("prettier "..current_file), '\n')
    formatted[#formatted] = nil
    if vim.v.shell_error ~= 0 then
      return false
    end
    api.nvim_buf_set_lines(bufnr, 0, -1, false, formatted)
    save()
  end
  return true
end

local function format_js_ts()
  local bufnr = api.nvim_get_current_buf();
  local current_file = api.nvim_buf_get_name(bufnr)
  save()
  prettier_fmt()
 end

local formatters = {
  rust = function() vim.cmd('RustFmt') end,
  go = function() print('No formatter installed for go.') end,
  c = function() print('No formatter installed for c.') end,
  javascript = prettier_fmt,
  javascriptreact = prettier_fmt,
  typescript = prettier_fmt,
  typescriptreact = prettier_fmt,
  html = prettier_fmt,
  css = prettier_fmt,
  json = prettier_fmt,
}

function M.format()
  local bufnr = api.nvim_get_current_buf()
  local ft = api.nvim_buf_get_option(bufnr, 'ft')
  local fn = formatters[ft] or function() end
  fn()
end

function M.setup()
  api.nvim_exec("command! -nargs=0 Format :lua require'formatter'.format()<CR>", "")
end

return M
