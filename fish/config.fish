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
eval (/opt/homebrew/bin/brew shellenv)

# Homebrew alias
alias up "brew update"
alias upgr "brew upgrade"
alias doc "brew doctor"
alias clnp "brew cleanup"
alias bls "brew ls"
alias instl "brew install"
alias uninstl "brew uninstall"
alias srch "brew search"
alias inf "brew info"

# Exa (ls in Rust) alias
alias xa "exa -la --color=always --color-scale --git --sort=Name"

# Grep with color
alias rg "rg --color always"

# Less with color
alias less "less -R"

# Zoxide
alias d "z"
zoxide init fish | source

# Neovim
alias nv "nvim"

# fzf.fish
set fzf_fd_opts --hidden --exclude=.git
fzf_configure_bindings --directory=\cf --git_log=\cg --git_status=\cs

# Yesss, VI mode in a shell!
fish_vi_key_bindings
