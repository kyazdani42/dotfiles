let g:fzf_nvim_statusline = 0 " disable fzf statusline overwriting

let g:fzf_preview_command = 'bat --decorations never --theme=ansi-dark --color=always --style=grid {-1}'
let g:fzf_preview_filelist_command = 'rg --files --hidden --follow --no-messages -g \!"* *"'
let g:fzf_preview_preview_key_bindings = 'ctrl-f:preview-page-down,ctrl-u:preview-page-up,?:toggle-preview'

nnoremap <silent> <C-p> :FzfPreviewProjectFiles<CR>
nnoremap <silent> <leader>; :FzfPreviewBuffers<CR>
nnoremap <silent> <leader>f :FzfPreviewProjectGrep<CR>


