if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end

alias pacman="sudo pacman"
alias gitbeauty="git log --all --graph --oneline"
alias ls="exa"
alias cat="bat"
alias vim="nvim"

cat ~/todo
