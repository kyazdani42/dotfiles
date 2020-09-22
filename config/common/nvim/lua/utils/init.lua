local a = vim.api

local M = {}

function M.mapper(mode, key, result)
  a.nvim_buf_set_keymap(0, mode, key, result, { noremap = true, silent = true })
end

function M.warn(msg)
  vim.cmd("echohl WarningMsg | echo '"..msg.."' | echohl Normal")
end

return M
