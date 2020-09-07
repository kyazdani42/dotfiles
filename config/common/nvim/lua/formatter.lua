local api = vim.api
local M = {}

local function has_eslint()
  return vim.fn.executable('eslint') == 1
end

local function has_prettier()
  return vim.fn.executable('prettier') == 1
end

local function format_js()
    local bufnr = api.nvim_get_current_buf();
    local current_file = api.nvim_buf_get_name(bufnr)
    vim.cmd('w')

    if has_prettier() then
      local formatted = vim.split(vim.fn.system("prettier "..current_file), '\n')
      api.nvim_buf_set_lines(bufnr, 0, -1, false, formatted)
    end

    if has_eslint() then
      vim.fn.system('eslint --fix '..current_file)
    end
end

local formatters = {
  javascript = format_js,
  javascriptreact = format_js,
  rust = function() vim.cmd('RustFmt') end,
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
