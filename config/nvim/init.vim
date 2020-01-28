let mapleader =" "

set relativenumber              " Relative numbers
set showmatch                   " Show matching brackets/parenthesis
set cursorline                  " Highlight current line
set noshowmode                  " Do not output message on the bottom
set mousehide                   " Hide mouse while typing
set linebreak                   " Do not break words
set splitbelow splitright       " Splits open on the bottom or on the right
set laststatus=2                " Use StatusBar on all windows, 2 = always
set scrolloff=8                 " Lines from the cursor
set wildmode=longest,list,full  " Command line completion mode
set noincsearch                 " Do not move cursor during search
set ignorecase                  " Ignore case
set hlsearch                    " Highlight search results (enforce)
set confirm                     " Disable 'no write'
set mouse=n                     " Enable mouse
set smartindent                 " auto indent on new line (brackets for instance)
set tabstop=4                   " Tabs are 4 spaces long
set shiftwidth=4                " Number of space for autoindent

" Disable autocommenting on newline
autocmd! Filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Retrieve last position in a file: https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

autocmd BufNewFile,BufRead *.tsx set syntax=typescript
autocmd BufNewFile,BufRead *.jsx set syntax=javascript

autocmd FileType c,cpp set tabstop=8 shiftwidth=8 noexpandtab
autocmd FileType python set tabstop=4 shiftwidth=4 noexpandtab
autocmd FileType markdown set tabstop=4 shiftwidth=4 expandtab
autocmd FileType typescript,javascript set tabstop=2 shiftwidth=2 expandtab

map <C-j> <Nop>
inoremap <C-j> <Esc>
vnoremap <C-j> <Esc>

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <leader><leader> <c-^> 
nnoremap j gj
nnoremap k gk

nnoremap Q <Nop>
map <F1> <Nop>
imap <F1> <Nop>

cabbrev W w

" ============================= PLUGINS ============================= "

call plug#begin('~/.config/nvim/plugged')
Plug 'drewtempelmeyer/palenight.vim'    " Colorscheme
Plug 'itchyny/lightline.vim'            " The lightline at the bottom
Plug 'norcalli/nvim-colorizer.lua'      " Rgb/hex colorizer
Plug 'machakann/vim-highlightedyank'    " Highlight yanking
Plug 'preservim/nerdtree'               " File Explorer
Plug 'ryanoasis/vim-devicons'           " Some icons
Plug 'Xuyuanp/nerdtree-git-plugin'      " Git Plugin for nerdtree
Plug 'tomtom/tcomment_vim'              " Comments
Plug 'tpope/vim-surround'               " Change/delete surrounding char
Plug 'justinmk/vim-sneak'               " Better fast search using 's
Plug 'airblade/vim-rooter'              " Changes Vim working directory to project root 
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'                 " Fuzzy finder for quick file matching
Plug 'neovim/nvim-lsp'                   " Language server configurations
call plug#end()

source ~/.config/nvim/colors.vim

silent! lua require'colorizer'.setup()

map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeWinSize=30
" kill Nerd tree when its the last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Ctrl + / is outputing ++ (term configuration)
nmap <silent> ++ :TComment<CR>
vmap <silent> ++ :TComment<CR>

let g:highlightedyank_highlight_duration = 300

let g:sneak#label = 1
hi! link Sneak Normal

let g:fzf_nvim_statusline = 0 " disable fzf statusline overwriting
let g:fzf_layout = { 'down': '~45%' }

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noruler nornu 
      \| autocmd BufLeave <buffer> set laststatus=2 ruler relativenumber

nnoremap <silent> <leader>b :call fzf#vim#buffers()<CR>
nnoremap <silent> <leader>p :call fzf#vim#files('', fzf#vim#with_preview('right'))<CR>

nnoremap <silent> <leader>f :Rg<CR>
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" vim: set et sw=2 foldlevel=0 foldmethod=marker:
