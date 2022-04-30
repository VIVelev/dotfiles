# Language
set -gx LANG en_US.UTF-8

set -x EDITOR nvim

# FUN
alias starwars "nc towel.blinkenlights.nl 23"
alias stress "yes > /dev/null &"

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

# Homebrew setup
if test -z "$HOMEBREW_PREFIX"
    eval (/opt/homebrew/bin/brew shellenv)
end

# Homebrew alias
alias up "brew update"
alias upgr "brew upgrade"
alias doc "brew doctor"
alias clnp "brew cleanup"
alias bls "brew ls"
alias instl "brew install"
alias uninstl "brew uninstall"
alias autorm "brew autoremove"
alias srch "brew search"
alias inf "brew info"

# Exa (ls in Rust) alias
alias xa "exa -la --color=always --color-scale --git --sort=Name"

# Grep with color
alias rg "rg --color always"

# Less with color
alias less "less -R"

# Neovim
alias nv "nvim"

# IPython
set -x IPYTHONDIR ~/.config/ipython/

# Python setup a dev environmnet
alias pyenv "python3 -m venv .env --upgrade-deps && source .env/bin/activate.fish && pip install -r ~/dotfiles/pyenv.txt"

if status is-interactive
    # Zoxide
    alias d "z"
    zoxide init fish | source

    # Atuin
    atuin init fish | source

    # Yesss, VI mode in a shell!
    fish_vi_key_bindings
end

# Created by `pipx` on 2022-04-20 17:25:11
set PATH $PATH /Users/vivelev/.local/bin
