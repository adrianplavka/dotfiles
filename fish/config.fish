if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias z zoxide
alias v nvim
alias clipc pbcopy
alias clipp pbpaste
alias dot "z dotfiles"

abbr -a -- g git
abbr -a -- ga "git add"
abbr -a -- gc "git commit"
abbr -a -- gb "git branch"
abbr -a -- gbv "git branch -v"
abbr -a -- gc "git checkout"
abbr -a -- gcb "git checkout -b"
abbr -a -- gl "git log"
abbr -a -- gs "git status"
abbr -a -- k kubectl
abbr -a -- tmux "tmux -2"

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

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
set --export --prepend PATH "/Users/adrianplavka/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
