local M = {}

function M.prev()
  local diagnostics = vim.lsp.diagnostic.get(vim.api.nvim_get_current_buf())

  if #diagnostics == 0 then
    return require'utils'.warn("No diagnostics")
  end

  require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()
end

function M.next()
  local diagnostics = vim.lsp.diagnostic.get(vim.api.nvim_get_current_buf())

  if #diagnostics == 0 then
    return require'utils'.warn("No diagnostics")
  end

  require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()
end

return M
