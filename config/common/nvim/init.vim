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

au FileType c,cpp set tabstop=8 shiftwidth=8 noexpandtab
au FileType python set tabstop=4 shiftwidth=4 noexpandtab
au FileType markdown set tabstop=4 shiftwidth=4 conceallevel=2
au FileType typescriptreact,typescript,javascript,javascriptreact,lua set tabstop=2 shiftwidth=2

au TextYankPost * silent! lua require'vim.highlight'.on_yank({ timeout=500 })

call plug#begin('~/.config/nvim/plugged')
Plug 'airblade/vim-gitgutter'                                      " Git infos in gutter
Plug 'tpope/vim-fugitive'                                          " Git integration
Plug 'APZelos/blamer.nvim'                                         " Git blame virtual text

Plug 'junegunn/fzf.vim'                                            " fzf wrapper
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

Plug 'tpope/vim-surround'                                          " Change/delete surrounding char
Plug 'airblade/vim-rooter'                                         " Changes Vim working directory to project root 
Plug 'tomtom/tcomment_vim'                                         " Comments
Plug 'editorconfig/editorconfig-vim'                               " File format for projects

Plug 'norcalli/nvim-colorizer.lua'                                 " Rgb/hex colorizer
Plug 'sheerun/vim-polyglot'                                        " Language color pack

Plug 'rust-lang/rust.vim'                                          " Rust language support
Plug 'plasticboy/vim-markdown'                                     " Markdown support: TODO: remove when treesitter is ok with markdown

Plug 'neovim/nvim-lspconfig'                                       " Lsp configuration
Plug 'nvim-lua/completion-nvim'                                    " Better lsp completion menu

Plug 'michaelb/sniprun', {'do': 'bash install.sh'}                 " Run blocks of code :SnipRun

Plug 'ThePrimeagen/vim-be-good'

Plug 'neoclide/coc.nvim', {'branch': 'release', 'for': ['typescript', 'javascript', 'html', 'json', 'css', 'rust'] }
call plug#end()

set runtimepath+=~/dev/nvim_dev/plugs/nvim-tree.lua
set runtimepath+=~/dev/nvim_dev/plugs/blue-moon
set runtimepath+=~/dev/nvim_dev/plugs/nvim-treesitter
set runtimepath+=~/dev/nvim_dev/plugs/nvim-web-devicons
set runtimepath+=~/dev/nvim_dev/plugs/nvim-github
set runtimepath+=~/dev/nvim_dev/plugs/playground

lua require'init'.setup()
