let g:palenight_terminal_italics=1
colorscheme palenight

set background=dark
let g:lightline = { 'colorscheme': 'palenight' }

" some colors to override colorscheme
" These are declared as GUI colors because of 'termguicolors' attr
hi CursorLine guibg=#1c1f2b
hi LineNr guifg=#3a3f58
hi Visual guibg=#343a51
hi VisualNOS guibg=#343a51
hi Search guibg=#4c4b65 guifg=default
hi IncSearch guibg=#4c4b65 guifg=default
hi MatchParen gui=bold,underline guifg=#a77eca guibg=default

