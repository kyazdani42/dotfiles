bg="#292d3e"
fg="#ffffff"
cyan="#89ddff"
yellow="#ffcb6b"

local fzf_colors="16,hl:${yellow},hl+:${cyan},fg+:${fg},pointer:${cyan}"

export FZF_DEFAULT_OPTS="--no-info --prompt=' ' -i --color=${fzf_colors} --height=25%"
export FZF_ALT_C_COMMAND="fd --type d -HLi . . 2>/dev/null"
export FZF_DEFAULT_COMMAND="rg --hidden -l "" -g '!.git' . 2>/dev/null"
export FZF_PREVIEW_COMMAND="bat --decorations=never --theme=ansi-dark --color always {} 2>/dev/null"
_fzf_compgen_path() {
    fd -HLi . "$1" 2>/dev/null
}
_fzf_compgen_dir() {
    fd --type d -HLi . "$1" 2>/dev/null
}

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

bindkey '^O' fzf-cd-widget

function fvim() {
    file="$(fd -iLH -t file . . | fzf --reverse)"
    if [ -z "$file" ]; then
        return 0
    fi
    nvim "$file"
}
