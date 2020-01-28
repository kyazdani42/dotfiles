syntax on
set t_Co=256
set termguicolors
set background=dark
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

silent! colorscheme palenight

let g:palenight_terminal_italics=1
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

" TODO:
"hi LspDiagnosticsError
"hi LspDiagnosticsHint
"hi LspDiagnosticsInformation
"hi LspDiagnosticsUnderline
"hi LspDiagnosticsUnderlineError
"hi LspDiagnosticsUnderlineHint
"hi LspDiagnosticsUnderlineInformation
"hi LspDiagnosticsUnderlineWarning
"hi LspDiagnosticsWarning
