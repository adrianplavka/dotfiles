if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias z=zoxide
alias v=nvim
alias g=git
alias k=kubectl
alias clipc=pbcopy
alias clipp=pbpaste

alias dot="z dotfiles"
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
