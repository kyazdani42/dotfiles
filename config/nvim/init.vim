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

let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" ============================= PLUGINS ============================= "

call plug#begin('~/.config/nvim/plugged')
Plug 'drewtempelmeyer/palenight.vim'                                    " Colorscheme
Plug 'itchyny/lightline.vim'                                            " The lightline at the bottom
Plug 'norcalli/nvim-colorizer.lua'                                      " Rgb/hex colorizer
Plug 'tpope/vim-fugitive'                                               " Git integration
Plug 'machakann/vim-highlightedyank'                                    " Highlight yanking
Plug 'tomtom/tcomment_vim'                                              " Comments
Plug 'tpope/vim-surround'                                               " Change/delete surrounding char
Plug 'justinmk/vim-sneak'                                               " Better fast search using 's
Plug 'preservim/nerdtree'                                               " File explorer
Plug 'Xuyuanp/nerdtree-git-plugin'                                      " Git for file explorer
Plug 'airblade/vim-gitgutter'                                           " Little infos in the gutter for git
Plug 'airblade/vim-rooter'                                              " Changes Vim working directory to project root 
Plug 'neovim/nvim-lsp'                                                  " Language server configurations
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }       " Fuzzy finder install
Plug 'junegunn/fzf.vim'                                                 " Fuzzy finder for quick file matching
call plug#end()

source ~/.config/nvim/colors.vim

silent! lua require'colorizer'.setup()

nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <C-]> <cmd>lua vim.lsp.buf.definition()<CR>

lua <<EOF
local nvim_lsp = require'nvim_lsp'
nvim_lsp.vimls.setup{}
nvim_lsp.bashls.setup{}
EOF

nnoremap <silent> <C-n> :NERDTreeToggle<CR>

" Ctrl + / is outputing ++ (term configuration)
nmap <silent> ++ :TComment<CR>
vmap <silent> ++ :TComment<CR>

let g:highlightedyank_highlight_duration = 300

let g:sneak#label = 1
hi! link Sneak Normal

let g:fzf_nvim_statusline = 0 " disable fzf statusline overwriting

function! CreateCenteredFloatingWindow()
    let width = min([&columns - 4, max([80, &columns - 20])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }

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
