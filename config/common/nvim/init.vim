" My Neovim Configuration "
" ----------------------- "
"  Yazdani Kiyan          "
"  github.com/kyazdani42  "
"-------------------------"

" Configs {{{

let mapleader = " "

set relativenumber             " Relative numbers
set showmatch                  " Show matching brackets/parenthesis
set cursorline                 " Highlight current line
set noshowmode                 " Do not output message on the bottom
set mousehide                  " Hide mouse while typing
set linebreak                  " Do not break words
set splitbelow splitright      " Splits open on the bottom or on the right
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
syntax sync fromstart

" Retrieve last position in a file: https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Disable autocommenting on newline: https://stackoverflow.com/questions/6076592/vim-set-formatoptions-being-lost
au BufNewFile,BufWinEnter * setlocal formatoptions-=cro

au BufNewFile,BufRead *.tsx set syntax=typescript.tsx
au BufNewFile,BufRead *.jsx set syntax=javascript.jsx

au FileType c,cpp set tabstop=8 shiftwidth=8 noexpandtab
au FileType python set tabstop=4 shiftwidth=4 noexpandtab
au FileType markdown set tabstop=4 shiftwidth=4 expandtab
au FileType typescript,javascript,lua set tabstop=2 shiftwidth=2 expandtab
au FileType markdown set conceallevel=2

nmap <C-c> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Plugins {{{

call plug#begin('~/.config/nvim/plugged')
Plug 'norcalli/nvim-colorizer.lua'                                      " Rgb/hex colorizer
Plug 'tpope/vim-fugitive'                                               " Git integration
Plug 'junegunn/fzf.vim'                                                 " fzf wrapper
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'tomtom/tcomment_vim'                                              " Comments
Plug 'tpope/vim-surround'                                               " Change/delete surrounding char
Plug 'junegunn/goyo.vim'                                                " Centers text
Plug 'justinmk/vim-sneak'                                               " Better fast search using 's
Plug 'ryanoasis/vim-devicons'                                           " Icons
Plug 'airblade/vim-gitgutter'                                           " Little infos in the gutter for git
Plug 'editorconfig/editorconfig-vim'                                    " File format for projects
Plug 'airblade/vim-rooter'                                              " Changes Vim working directory to project root 
Plug 'sheerun/vim-polyglot'                                             " Language color pack
Plug 'rust-lang/rust.vim'                                               " Rust language support
Plug 'plasticboy/vim-markdown'                                          " Markdown support
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'nvim-treesitter/playground'
call plug#end()

au TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 300)

set runtimepath+=~/dev/nvim_dev/plugs/nvim-tree.lua
set runtimepath+=~/dev/nvim_dev/plugs/blue-moon
set runtimepath+=~/dev/nvim_dev/plugs/nvim-treesitter
set runtimepath+=~/dev/nvim_dev/plugs/nvim-web-devicons

colorscheme blue-moon
lua require'init'.setup()

let g:sneak#label = 1
hi! link Sneak Normal
