if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias z=zoxide
alias v=nvim
alias g=git
alias ga="git add"
alias gc="git commit"
alias gs="git status"
alias gbv="git branch -v"
alias gbl="git branch -l"
alias k=kubectl
alias clipc=pbcopy
alias clipp=pbpaste
alias tmux="tmux -2"
alias dot="z dotfiles"

export VISUAL=nvim
export MANPAGER=nvim
export EDITOR=nvim
export GIT_EDITOR=nvim
export KUBE_EDITOR=nvim

if type -q zoxide
    z init fish | source
end

if type -q mise
    mise activate fish | source
end

if type -q direnv
    direnv hook fish | source
end

set -l EXTENDS_CONFIG_PATH ~/.extends.fish
if test -f "$EXTENDS_CONFIG_PATH"
    source $EXTENDS_CONFIG_PATH
end
