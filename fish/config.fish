# Language
set -gx LANG en_US.UTF-8

# GOPATH
set -x GOPATH ~/golang/

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
alias gbd "git branch -d"
alias gco "git checkout"
alias gm "git merge"

alias gl "git pull"
alias gp "git push"

alias grst-h "git reset --hard"

alias glsc "git ls-files | xargs wc -l"

# Homebrew alias
alias boo "brew update && brew upgrade && brew upgrade --cask && brew cleanup && brew doctor"

# Exa (ls in Rust) alias
alias xa "exa -la"

# pip update
alias pip-up "pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U"


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
    remove_from_path /Users/vivelev/.pyenv/shims /Users/vivelev/.nvm/versions/node/v14.15.1/bin

    # NVM Setup
    function nvm
       bass source /usr/local/opt/nvm/nvm.sh --no-use ';' nvm $argv
    end
    set -x NVM_DIR ~/.nvm
    nvm use default --silent

    # Pyenv Setup
    pyenv init - | source
    ## NOTE: this is a tmp fix to *pyenv not finding zlib & bzip3 in macos 11*
    set -gx LDFLAGS -L/usr/local/opt/zlib/lib -L/usr/local/opt/bzip2/lib
    set -gx CPPFLAGS -I/usr/local/opt/zlib/include -I/usr/local/opt/bzip2/include
end
dSetup

# Start tmux automatically
if not set -q TMUX
    eval tmux -f ~/.config/tmux/config new -s base
    eval tmux a -t base
end
