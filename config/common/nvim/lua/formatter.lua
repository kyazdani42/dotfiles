local api = vim.api
local M = {}

local function has_ex(ex)
  return vim.fn.executable(ex) == 1
end

local function save()
  vim.cmd('w')
end

local function prettier_fmt()
  local bufnr = api.nvim_get_current_buf();
  local current_file = api.nvim_buf_get_name(bufnr)

  if has_ex('prettier') then
    local formatted = vim.split(vim.fn.system("prettier "..current_file), '\n')
    if vim.v.shell_error ~= 0 then
      return false
    end
    api.nvim_buf_set_lines(bufnr, 0, -1, false, formatted)
    save()
  end
  return true
end

local function format_js()
  local bufnr = api.nvim_get_current_buf();
  local current_file = api.nvim_buf_get_name(bufnr)
  save()

  if not prettier_fmt() then
    return
  end

  if has_ex('eslint') then
    vim.fn.system('eslint --fix '..current_file)
    vim.cmd('edit!')
  end
end

local function format_ts()
  local bufnr = api.nvim_get_current_buf();
  local current_file = api.nvim_buf_get_name(bufnr)
  save()

  if not prettier_fmt() then
    return
  end

  if has_ex('tslint') then
    vim.fn.system('tslint --fix '..current_file)
    vim.cmd('edit!')
  end
end

local formatters = {
  javascript = format_js,
  javascriptreact = format_js,
  typescript = format_ts,
  typescriptreact = format_ts,
  rust = function() vim.cmd('RustFmt') end,
  html = function() save(); prettier_fmt() end,
  css = function() save(); prettier_fmt() end
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
