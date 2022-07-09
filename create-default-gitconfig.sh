#!/usr/bin/env bash

if [ -f "$HOME/.gitconfig" ]; then
    exit 0;
fi

cat > $HOME/.gitconfig <<EOF
[core]
    pager = delta

[interactive]
    diffFilter = delta --color-only

[delta]
    navigate = true
    light = false
    whitespace-error-style = 22 reverse
    syntax-theme = Monokai Extended
    map-styles = \
       bold purple => syntax "#4a2432", \
       bold blue => syntax "#444267", \
       bold cyan => syntax "#32374d", \
       bold yellow => syntax "#43433f"

[delta "decorations"]
    commit-decoration-style = bold yellow box ul
    file-style = bold yellow ul
    file-decoration-style = none

[alias]
	s = status
    df = diff
    ds = diff --staged
    co = "!git add . -p && git commit"
    ls = "!gitbeauty"
    ll = "!gitbeauty --more"
    cm = commit --amend
    coi = add . --intent-to-add
    rb = rebase -i
    br = branch -a
    clbr = "!git branch -D $(git branch | grep -v '\\*')"
    base-commit-from-main = show-branch --merge-base main
    base-commit-from-master = show-branch --merge-base master
    base-commit = show-branch --merge-base

[pull]
	rebase = true

[diff]
    colorMoved = default

[filter "lfs"]
	clean = git-lfs clean -- %f
	smudge = git-lfs smudge -- %f
	process = git-lfs filter-process
	required = true
EOF
