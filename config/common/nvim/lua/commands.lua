function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, {...})
  print(unpack(objects))
end

local function nvim_set_au(au_type, where, dispatch)
  vim.cmd(string.format("au! %s %s %s", au_type, where, dispatch))
end

-- Disable autocommenting on newline and retrieve last position
nvim_set_au("BufWinEnter", "*", [[exec "normal! g'\""]])
nvim_set_au("TextYankPost", "*",  [[silent! lua require'vim.highlight'.on_yank({ timeout=500 })]])
nvim_set_au("FileType", "scheme", "set ft=query")
nvim_set_au("BufNewFile,BufRead", "*.gql,*.graphql", "set ft=graphql")
nvim_set_au("BufNewFile,BufRead", ".eslintrc", "set ft=json")
nvim_set_au("BufNewFile,BufRead", ".prettierrc", "set ft=json")
nvim_set_au("BufNewFile,BufRead", ".swcrc", "set ft=json")
nvim_set_au("FileType", "c,cpp", "set tabstop=8 shiftwidth=4 noexpandtab")
nvim_set_au("FileType", "python", "set tabstop=4 shiftwidth=4 noexpandtab")
nvim_set_au("FileType", "markdown", "set tabstop=4 shiftwidth=4 conceallevel=2")
nvim_set_au("FileType", "typescriptreact,typescript,javascript,javascriptreact,lua,html,css,graphql", "set tabstop=2 shiftwidth=2")
nvim_set_au("BufWritePost", "*.tex", ":silent !pdflatex % &>/dev/null")

vim.cmd "cabbrev W w"
vim.cmd "cabbrev Xa xa"

vim.cmd "command! Dnd :!dragon-drag-and-drop %"
