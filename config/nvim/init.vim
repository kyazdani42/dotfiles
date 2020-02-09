" My Neovim Configuration "
" ----------------------- "
"  Yazdani Kiyan          "
"  github.com/kyazdani42  "
"-------------------------"

" Config {{{

let mapleader =" "

set relativenumber             " Relative numbers
set showmatch                  " Show matching brackets/parenthesis
set cursorline                 " Highlight current line
set noshowmode                 " Do not output message on the bottom
set mousehide                  " Hide mouse while typing
set linebreak                  " Do not break words
set splitbelow splitright      " Splits open on the bottom or on the right
set laststatus=2               " Use StatusBar on all windows, 2 = always
set scrolloff=8                " Lines from the cursor
set wildmode+=longest,full     " Command line completion mode
set noincsearch                " Do not move cursor during search
set ignorecase                 " Ignore case
set hlsearch                   " Highlight search results (enforce)
set confirm                    " Disable 'no write'
set mouse=n                    " Enable mouse
set smartindent                " auto indent on new line (brackets for instance)
set tabstop=4                  " Tabs are 4 spaces long
set shiftwidth=4               " Number of space for autoindent
set expandtab                  " expand tab into space by default

" Retrieve last position in a file: https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Disable autocommenting on newline: https://stackoverflow.com/questions/6076592/vim-set-formatoptions-being-lost
autocmd BufNewFile,BufWinEnter * setlocal formatoptions-=cro

autocmd BufNewFile,BufRead *.tsx set syntax=typescript
autocmd BufNewFile,BufRead *.jsx set syntax=javascript

autocmd FileType c,cpp set tabstop=8 shiftwidth=8 noexpandtab
autocmd FileType python set tabstop=4 shiftwidth=4 noexpandtab
autocmd FileType markdown set tabstop=4 shiftwidth=4 expandtab
autocmd FileType typescript,javascript set tabstop=2 shiftwidth=2 expandtab

" }}}

" Mappings {{{

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

" }}}

" Plugins {{{

let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1 " Disable netrw

call plug#begin('~/.config/nvim/plugged')
Plug 'drewtempelmeyer/palenight.vim'                                    " Colorscheme
Plug 'itchyny/lightline.vim'                                            " The lightline at the bottom
Plug 'norcalli/nvim-colorizer.lua'                                      " Rgb/hex colorizer
Plug 'tpope/vim-fugitive'                                               " Git integration
Plug 'machakann/vim-highlightedyank'                                    " Highlight yanking
Plug 'tomtom/tcomment_vim'                                              " Comments
Plug 'tpope/vim-surround'                                               " Change/delete surrounding char
Plug 'junegunn/goyo.vim'                                                " Centers text
Plug 'justinmk/vim-sneak'                                               " Better fast search using 's
Plug 'ryanoasis/vim-devicons'                                           " Icons
Plug 'airblade/vim-gitgutter'                                           " Little infos in the gutter for git
Plug 'airblade/vim-rooter'                                              " Changes Vim working directory to project root 
Plug 'neovim/nvim-lsp'                                                  " Lsp setup
Plug 'kyazdani42/nvim-tree.lua'                                         " My tree
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }       " Fuzzy finder install
Plug 'junegunn/fzf.vim'                                                 " Fuzzy finder for quick file matching
call plug#end()

source ~/.config/nvim/colors.vim

silent! lua require'colorizer'.setup()

nnoremap <silent> K           <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>k   <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gd          <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gD          <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> 1gD         <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr          <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <C-]>       <cmd>lua vim.lsp.buf.definition()<CR>

lua <<EOF
local nvim_lsp = require'nvim_lsp'
nvim_lsp.vimls.setup{}
nvim_lsp.bashls.setup{}
nvim_lsp.tsserver.setup{}
nvim_lsp.sumneko_lua.setup{}
EOF

nnoremap <silent> <leader>n :LuaTree<CR>

" Ctrl + / is outputing ++ (term configuration)
nmap <silent> ++ :TComment<CR>
vmap <silent> ++ :TComment<CR>

let g:highlightedyank_highlight_duration = 300

let g:sneak#label = 1
hi! link Sneak Normal

let g:lightline = {
      \ 'colorscheme': 'palenight',
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ },
\ }

function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

source ~/.config/nvim/fzf.vim

" }}}

" vim: set sw=2 foldlevel=0 foldmethod=marker:
