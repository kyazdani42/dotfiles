local M = {}

local current_diagnostic = 1

local function jump(diagnostic)
  if not diagnostic then return end
  vim.api.nvim_win_set_cursor(0, {diagnostic.range.start.line+1, diagnostic.range.start.character})
end

function M.prev()
  local diagnostics = vim.lsp.util.diagnostics_by_buf[vim.api.nvim_get_current_buf()]

  if #diagnostics == 0 then
    return require'utils'.warn("No diagnostics")
  end

  if #diagnostics == 1 or current_diagnostic == 1 then
    current_diagnostic = #diagnostics
  else
    current_diagnostic = current_diagnostic - 1
  end

  jump(diagnostics[current_diagnostic])
end

function M.next()
  local diagnostics = vim.lsp.util.diagnostics_by_buf[vim.api.nvim_get_current_buf()]

  if #diagnostics == 0 then
    return require'utils'.warn("No diagnostics")
  end
  if #diagnostics == 1 or current_diagnostic >= #diagnostics then
    current_diagnostic = 1
  else
    current_diagnostic = current_diagnostic + 1
  end

  jump(diagnostics[current_diagnostic])
end

return M
