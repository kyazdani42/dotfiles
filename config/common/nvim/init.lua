local o = vim.o
local g = vim.g
local a = vim.api

g.mapleader = '\\'

o.updatetime = 800
o.foldlevelstart = 99
o.termguicolors = true
o.mouse= 'n' -- Enable mouse
o.ignorecase = true -- Ignore case
o.confirm = true -- Disable 'no write'
o.scrolloff = 8 -- Lines from the cursor
o.incsearch = true -- Move cursor during search
o.splitright = true -- Splits open on the right
o.splitbelow = true -- Splits open on the bottom
o.wildmenu = true -- Command line completion mode
o.wildmode = 'full' -- Command line completion mode
o.hlsearch = true -- Highlight search results (enforce)
o.showmatch = true -- Show matching brackets/parenthesis
o.showmode = false -- Do not output message on the bottom
o.inccommand = 'split' -- Show effects of command as you type in a split
o.clipboard = 'unnamedplus' -- Use system clipboard
o.shortmess = vim.o.shortmess .. 'c'

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
nvim_set_au("BufNewFile,BufRead", "*.gql", "set ft=graphql")
nvim_set_au("BufNewFile,BufRead", ".eslintrc", "set ft=json")
nvim_set_au("BufNewFile,BufRead", ".prettierrc", "set ft=json")
nvim_set_au("BufNewFile,BufRead", ".swcrc", "set ft=json")
nvim_set_au("FileType", "c,cpp", "set tabstop=8 shiftwidth=4 noexpandtab")
nvim_set_au("FileType", "python", "set tabstop=4 shiftwidth=4 noexpandtab")
nvim_set_au("FileType", "markdown", "set tabstop=4 shiftwidth=4 conceallevel=2")
nvim_set_au("FileType", "typescriptreact,typescript,javascript,javascriptreact,lua,html", "set tabstop=2 shiftwidth=2")
nvim_set_au("FileType", "LuaTree", "lua vim.api.nvim_buf_set_keymap(0, 'n', '<C-p>', ':wincmd l | :Files<CR>', {silent=true})")
nvim_set_au("FileType", "LuaTree", "lua vim.api.nvim_buf_set_keymap(0, 'n', '<C-b>', ':wincmd l | :Buffers<CR>', {silent=true})")
nvim_set_au("FileType", "LuaTree", "lua vim.api.nvim_buf_set_keymap(0, 'n', '<C-t>', ':wincmd l | :RG<CR>', {silent=true})")

vim.cmd "cabbrev W w"

function _G.set_buffer_options()
  vim.bo.formatoptions= vim.bo.formatoptions:gsub('[cro]', '')
  vim.bo.smartindent = true
end

vim.cmd "au BufEnter * lua set_buffer_options()"

a.nvim_exec([[
  set expandtab
  set shiftwidth=4
  set tabstop=4

  " we have to set these window options here because vim.o won't accept them and vim.wo wont set for each window automatically
  " and binding to an autocmd will mess with window that change those settings
  set relativenumber
  set cursorline
  set linebreak
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
  set signcolumn=yes
  ]], '')

require 'plugins'

local function map(mod, lhs, rhs, opt)
  a.nvim_set_keymap(mod, lhs, rhs, opt or {})
end

map('', '<C-j>', '', { nowait = true })
map('i', '<C-j>', '<ESC>', { nowait = true })
map('v', '<C-j>', '<ESC>', { nowait = true })

map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')
map('n', '<C-h>', '<C-w>h')

map('n', '<leader>v', ':noh<CR>', { silent=true })

map('n', 'j', 'gj')
map('n', 'k', 'gk')
map('n', '<space><space>', '<c-^>')
map('n', '<leader><leader>', ':tabnext<CR>')

map('n', 'Q', '')
map('n', '<F1>', '')
map('i', '<F1>', '')

map('n', '<C-u>', '<C-u>zz')
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-f>', '<C-f>zz')

map('n', '++', ':TComment<cr>', { silent = true }) -- Ctrl + / is outputing ++ (term configuration)
map('v', '++', ':TComment<cr>', { silent = true })
map('n', '<tab>', ':normal za<cr>', { noremap = true, silent = true })

require 'statusline'.setup()
require 'formatter'.setup()
require 'fuzzy'.setup()
