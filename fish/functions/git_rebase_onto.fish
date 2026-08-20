function git_rebase_onto --description 'Rebase the current branch onto another branch'
    if test (count $argv) -lt 1
        echo "usage: git_rebase_onto <branch> [remote]" >&2
        return 1
    end

    set -l target $argv[1]
    set -l remote $argv[2]
    test -n "$remote"; or set remote origin

    if not git rev-parse --is-inside-work-tree >/dev/null 2>&1
        echo "git_rebase_onto: not a git repository" >&2
        return 1
    end

    set -l current (git branch --show-current)

    if test -z "$current"
        echo "git_rebase_onto: detached HEAD — check out a branch first" >&2
        return 1
    end

    if test "$current" = "$target"
        echo "git_rebase_onto: already on '$target'" >&2
        return 1
    end

    echo "Fetching $remote/$target…"
    git fetch $remote $target; or return $status

    echo "Rebasing '$current' onto $remote/$target…"
    git rebase --autostash $remote/$target
end

complete -c git_rebase_onto -f -a "(git branch --format='%(refname:short)' 2>/dev/null)"
