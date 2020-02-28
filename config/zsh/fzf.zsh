bg="#292d3e"
fg="#e7edf9"
cyan="#89ddff"
export FZF_DEFAULT_OPTS=" --prompt=' ' -i --color=bg:${bg},fg:#676e95,hl:${cyan},bg+:${bg},fg+:${fg},hl+:${cyan},gutter:${bg},spinner:${bg},info:${bg},prompt:${bg},pointer:${cyan}"

export FZF_ALT_C_COMMAND="fd --type d -HLi . ."
export FZF_DEFAULT_COMMAND="rg --hidden -l "" -g '!.git' ."
export FZF_PREVIEW_COMMAND="bat --decorations=never --theme=ansi-dark --color always {}"

_fzf_compgen_path() {
    fd -HLi . "$1"
}
# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
    fd --type d -HLi . "$1"
}

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

bindkey '^O' fzf-cd-widget

function fvim() {
    file="$(fd -iLH -t file . . | fzf)"
    if [ -z "$file" ]; then
        return 0
    fi
    nvim "$file"
}
