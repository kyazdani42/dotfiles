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
Plug 'kyazdani42/nvim-tree.lua'                                         " My tree
Plug 'kyazdani42/highlight.lua'                                         " Highlight experiments using treesitter
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }       " Fuzzy finder install
Plug 'yuki-ycino/fzf-preview.vim'                                       " Better plugin for fzf
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}      " Lsp
Plug 'rust-lang/rust.vim'                                               " Rust language support
call plug#end()

silent! lua require'colors'.setup()
silent! lua require'colorizer'.setup()
silent! lua require'fzf'.setup()

let g:lua_tree_ignore = ['.git', 'node_modules']
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
      \ 'active': {
      \   'left': [
      \     ['mode'], [ 'filename' ], ['git', 'blame'],
      \     [ 'readonly', 'modified' ]
      \   ],
      \   'right': [
      \     [], [ 'filetype', 'fileencoding', 'lineinfo', 'percent' ]
      \   ],
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename'
      \ },
      \ }

function! LightlineFilename()
  return expand('%:t') !=# '' ? WebDevIconsGetFileTypeSymbol(@%) . ' ' . @% : '[No Name]'
endfunction

set hidden           " TextEdit might fail if hidden is not set.
set nobackup         " Some lsp have issues with backup files, see #649.
set nowritebackup
set cmdheight=2      " Give more space for displaying messages.
set updatetime=300   " Update time for lsp cycles
set shortmess+=c     " Don't pass messages to |ins-completion-menu|.
set signcolumn=yes   " Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved.

inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

nnoremap <silent> <leader>j <Plug>(coc-diagnostic-prev)
nnoremap <silent> <leader>k <Plug>(coc-diagnostic-next)

nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gt <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)
nnoremap <leader>rn  <Plug>(coc-rename)
vnoremap <C-I>  <Plug>(coc-format-selected)
nnoremap <C-I>  <Plug>(coc-format-selected)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

command! -nargs=0 Format :call CocAction('format')
command! -nargs=0 OR     :call CocAction('runCommand', 'editor.action.organizeImport')

" }}}

" vim: set sw=2 foldlevel=0 foldmethod=marker
