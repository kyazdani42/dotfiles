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

lua require 'init'
