# Language
set -gx LANG en_US.UTF-8

set -x EDITOR nvim

# FUN
abbr starwars nc towel.blinkenlights.nl 23
abbr stress yes > /dev/null &

# git alias
alias ga "git add"
alias gaa "git add --all"
alias gst "git status"
alias gcm "git commit -m"
alias glg "git log --stat"

alias gb "git branch"
alias gco "git checkout"

alias gl "git pull"
alias gp "git push"

alias grst-h "git reset --hard"

alias glsc "git ls-files | xargs wc -l"

# Homebrew alias
alias boo "brew update && brew upgrade && brew upgrade --cask"

# Exa (ls in Rust) alias
alias xa "exa -la --color-scale --git --sort=Name"

# pip update
alias pip-up "pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U"

# Zoxide
alias d "z"

# Neovim
alias nv "nvim"

# fzf.fish
set fzf_fd_opts --hidden --exclude=.git
fzf_configure_bindings --directory=\cf --git_log=\cg --git_status=\cs

# Utils
function remove_from_path
    for p in $argv
        if set idx (contains -i $p $PATH)
            set -e PATH[$idx]
        end
    end
end

# Dynamic Setup of libraries
function dSetup
    remove_from_path /Users/vivelev/.pyenv/shims

    status is-login; and pyenv init --path | source
    status is-interactive; and pyenv init - | source

    zoxide init fish | source
end
dSetup

# Start tmux automatically
if not set -q TMUX
    eval tmux -f ~/.config/tmux/config new -s base
    eval tmux a -t base
end
