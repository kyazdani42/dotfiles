vim.api.nvim_exec([[
  let mapleader = "\\"

  set relativenumber             " Relative numbers
  set showmatch                  " Show matching brackets/parenthesis
  set cursorline                 " Highlight current line
  set noshowmode                 " Do not output message on the bottom
  set mousehide                  " Hide mouse while typing
  set linebreak                  " Do not break words
  set splitbelow splitright      " Splits open on the bottom or on the right
  set updatetime=800
  set scrolloff=8                " Lines from the cursor
  set wildmode=full              " Command line completion mode
  set wildmenu                   " Command line completion mode
  set incsearch                  " Move cursor during search
  set inccommand=split           " Show effects of command as you type in a split
  set ignorecase                 " Ignore case
  set hlsearch                   " Highlight search results (enforce)
  set confirm                    " Disable 'no write'
  set mouse=n                    " Enable mouse
  set smartindent                " auto indent on new line (brackets for instance)
  set tabstop=4                  " Tabs are 4 spaces long
  set shiftwidth=4               " Number of space for autoindent
  set expandtab                  " expand tab into space by default
  set clipboard^=unnamedplus     " Use system clipboard
  set termguicolors
  set shortmess+=c
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
  set foldlevelstart=99

  " Retrieve last position in a file: https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

  " Disable autocommenting on newline: https://stackoverflow.com/questions/6076592/vim-set-formatoptions-being-lost
  au BufNewFile,BufWinEnter * setlocal formatoptions-=cro

  au FileType scheme set ft=query

  au FileType c,cpp set tabstop=8 shiftwidth=8 noexpandtab
  au FileType python set tabstop=4 shiftwidth=4 noexpandtab
  au FileType markdown set tabstop=4 shiftwidth=4 conceallevel=2
  au FileType typescriptreact,typescript,javascript,javascriptreact,lua set tabstop=2 shiftwidth=2

  au TextYankPost * silent! lua require'vim.highlight'.on_yank({ timeout=500 })

  cabbrev W w
  cabbrev terminal vsplit term://zsh
  cabbrev term vsplit term://zsh
  autocmd TermOpen * startinsert
  ]], '')

require 'plugins'

local keymaps = {
  { mod = '', lhs = '<C-j>', rhs = '', opt = {nowait = true} },
  { mod = 'i', lhs = '<C-j>', rhs = '<Esc>' },
  { mod = 'v', lhs = '<C-j>', rhs = '<Esc>' },

  { mod = 'n', lhs = '<C-j>', rhs = '<C-w>j' },
  { mod = 'n', lhs = '<C-k>', rhs = '<C-w>k' },
  { mod = 'n', lhs = '<C-l>', rhs = '<C-w>l' },
  { mod = 'n', lhs = '<C-h>', rhs = '<C-w>h' },

  { mod = 'n', lhs = '<leader>v', rhs = ':noh<CR>', opt = {silent=true} },

  { mod = 'n', lhs = 'j', rhs = 'gj' },
  { mod = 'n', lhs = 'k', rhs = 'gk' },
  { mod = 'n', lhs = '<space><space>', rhs = '<c-^>' },
  { mod = 'n', lhs = '<leader><leader>', rhs = ':tabnext<CR>' },

  { mod = 'n', lhs = 'Q', rhs = '' },
  { mod = 'n', lhs = '<F1>', rhs = '' },
  { mod = 'i', lhs = '<F1>', rhs = '' },

  { mod = 'n', lhs = '<C-u>', rhs = '<C-u>zz' },
  { mod = 'n', lhs = '<C-d>', rhs = '<C-d>zz' },
  { mod = 'n', lhs = '<C-f>', rhs = '<C-f>zz' },
  { mod = 'n', lhs = '(', rhs = '(zz' },
  { mod = 'n', lhs = ')', rhs = ')zz' },
  { mod = 'v', lhs = '(', rhs = '(zz' },
  { mod = 'v', lhs = ')', rhs = ')zz' },

  -- Ctrl + / is outputing ++ (term configuration)
  { mod = 'n', lhs = '++', rhs = ':TComment<cr>', opt = { silent = true } },
  { mod = 'v', lhs = '++', rhs = ':TComment<cr>', opt = { silent = true } },
  { mod = 'n', lhs = '<tab>', rhs = ':normal za<cr>', opt = { noremap = true, silent = true }},

  -- TODO: find a way to map that but not on fzf
  -- { mod = 't', lhs = '<C-k>', rhs = '<C-\\><C-n>', opt = { noremap = true } },
  { mod = 't', lhs = '<C-w>h', rhs = '<C-\\><C-n><c-w>h', opt = { noremap = true } },
  { mod = 't', lhs = '<C-w>j', rhs = '<C-\\><C-n><c-w>j', opt = { noremap = true } },
  { mod = 't', lhs = '<C-w>k', rhs = '<C-\\><C-n><c-w>k', opt = { noremap = true } },
  { mod = 't', lhs = '<C-w>l', rhs = '<C-\\><C-n><c-w>l', opt = { noremap = true } },
}

local default_opt = { nowait = true, noremap = true }

for _, keymap in pairs(keymaps) do
  vim.api.nvim_set_keymap(keymap.mod, keymap.lhs, keymap.rhs, keymap.opt or default_opt)
end

require 'statusline'.setup()
require 'formatter'.setup()
require 'fuzzy'.setup()
-- require 'nvim-github'.setup()
