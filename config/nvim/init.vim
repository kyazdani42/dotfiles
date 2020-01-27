let mapleader =" "

" ==================================
" Plugins
" ==================================

call plug#begin('~/.config/nvim/plugged')
" Colors
Plug 'drewtempelmeyer/palenight.vim'

"the lightline at the bottom
Plug 'itchyny/lightline.vim'

Plug 'ryanoasis/vim-devicons'

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

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
filetype plugin indent on
set termguicolors
set t_Co=256
syntax on

" TODO: find a way to make this relative
source ~/.config/nvim/colors.vim

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

let g:fzf_nvim_statusline = 0 " disable statusline overwriting
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

nnoremap <silent> <C-p> :call FzfFileIcons('')<CR>

function! FzfFileIcons(qargs)
  let l:fzf_files_options = '--preview "bat --theme=ansi-dark --decorations=never --color always {2..-1} | head -'.&lines.'" --expect=ctrl-t,ctrl-v,ctrl-x --multi --bind=ctrl-a:select-all,ctrl-d:deselect-all'

  function! s:files(dir)
    let l:cmd = $FZF_DEFAULT_COMMAND
    if a:dir != ''
      let l:cmd .= ' ' . shellescape(a:dir)
    endif
    let l:files = split(system(l:cmd), '\n')
    return s:prepend_icon(l:files)
  endfunction

  function! s:prepend_icon(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:filename = fnamemodify(l:candidate, ':p:t')
      let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
      call add(l:result, printf('%s %s', l:icon, l:candidate))
    endfor

    return l:result
  endfunction
  
  function! s:edit_file(lines)
    if len(a:lines) < 2 | return | endif

    let l:cmd = get({'ctrl-x': 'split',
                 \ 'ctrl-v': 'vertical split',
                 \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')
    
    for l:item in a:lines[1:]
      let l:pos = stridx(l:item, ' ')
      let l:file_path = l:item[pos+1:-1]
      execute 'silent '. l:cmd . ' ' . l:file_path
    endfor
  endfunction

  call fzf#run({
        \ 'source': <sid>files(a:qargs),
        \ 'sink*':   function('s:edit_file'),
        \ 'options': '-m ' . l:fzf_files_options,
        \ 'down':    '45%' })
endfunction

" vim: set et sw=2 foldlevel=0 foldmethod=marker:
