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
set clipboard^=unnamedplus     " Use system clipboard

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

lua require'init'.setup()

" }}}

" Plugins {{{

call plug#begin('~/.config/nvim/plugged')
Plug 'drewtempelmeyer/palenight.vim'                                    " Colorscheme
Plug 'lifepillar/vim-solarized8'                                        " Colorscheme
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
Plug 'yuki-ycino/fzf-preview.vim'                                       " Better plugin for fzf
call plug#end()

silent! lua require'colors'.setup()
silent! lua require'colorizer'.setup()
silent! lua require'lsp'.setup()
silent! lua require'fzf'.setup()

nnoremap <silent> <C-n> :LuaTreeToggle<CR>
nnoremap <silent> <leader>n :LuaTreeRefresh<CR>

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
  return expand('%:t') !=# '' ? WebDevIconsGetFileTypeSymbol(@%) . ' ' . @% : '[No Name]'
endfunction

" }}}

" vim: set sw=2 foldlevel=0 foldmethod=marker
