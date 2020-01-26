let mapleader =" "

" ==================================
" Plugins
" ==================================

call plug#begin('~/.vim/plugged')
	" Colors
    Plug 'drewtempelmeyer/palenight.vim'

    "the lightline at the bottom
    Plug 'itchyny/lightline.vim'

    " colorizer 
    Plug 'norcalli/nvim-colorizer.lua'

    " Comments
    Plug 'tomtom/tcomment_vim'
    " Ctrl + / is outputing ++ (term configuration)
    nmap <silent> ++ :TComment<CR>
    vmap <silent> ++ :TComment<CR>

    " Fuzzyfinder for vim
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    " Hilight when yanking
    Plug 'machakann/vim-highlightedyank'
    let g:highlightedyank_highlight_duration = 300

    " Change/delete surrounding char
    Plug 'tpope/vim-surround'
call plug#end()

filetype plugin indent on

syntax on

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
set t_Co=256

source ~/.vim/colors.vim

" disable autocommenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o 

lua require'colorizer'.setup()

set relativenumber " Relative numbers
set showmatch " Show matching brackets/parenthesis
set cursorline " Highlight current line
set noshowmode
set mousehide " hide mouse while typing
set linebreak " do not break words
set splitbelow splitright " Splits open on the bottom or on the right
set ruler " Show line and column number of cursor pos
set laststatus=2 " Use StatusBar on all windows, 2 = always
set scrolloff=9999 " Make cursor in middle of screen ?

" Indentation
set smartindent " auto indent on new line (brackets for instance)
set tabstop=4 " Tabs are 4 spaces long
set shiftwidth=4 " Number of space for autoindent

autocmd BufNewFile,BufRead *.tsx set syntax=typescript
autocmd BufNewFile,BufRead *.jsx set syntax=javascript
autocmd FileType typescript,javascript set tabstop=2 shiftwidth=2 expandtab

autocmd FileType c,cpp set tabstop=8 shiftwidth=8 noexpandtab
autocmd FileType python set tabstop=4 shiftwidth=4 noexpandtab
autocmd FileType markdown set tabstop=4 shiftwidth=4 expandtab

" Search settings
set noincsearch " Do not move cursor during search
set ignorecase " Ignore case
set hlsearch " Highlight search results

" Misc
set autoread " reload file when it changes
set confirm " disable 'no write'
set mouse=n " enable mouse
set backspace=indent,eol,start " Easy backspace
set encoding=utf-8 " displayed encoding
set fileencoding=utf-8 " written to file encoding
set nocompatible " Disable vi compatibility
set wildmode=longest,list,full " Command line completion mode
" Disable Ex mode
nnoremap Q <Nop>

" control j to escape
map <C-j> <Nop>
inoremap <C-j> <Esc>
noremap <C-j> <Esc>

"toggle buffer
nnoremap <leader><leader> <c-^>

" Oups
map <F1> <Esc>
imap <F1> <Esc>

map H ^
map L $

" Move by line
nnoremap j gj
nnoremap k gk

" https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

map <silent> <leader>b :Buffers<CR>
map <silent> <leader>f :Rg<CR>
nnoremap <silent> <leader>p :Files<CR>

let g:fzf_nvim_statusline = 0 " disable statusline overwriting
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noruler nornu 
      \| autocmd BufLeave <buffer> set laststatus=2 ruler relativenumber

let g:fzf_layout = { 'down': '~25%' }

" vim: set et sw=2 foldlevel=0 foldmethod=marker:
