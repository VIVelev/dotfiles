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

# Exa (ls in Rust) alias
alias xa "exa -la --color-scale --git --sort=Name"

# Zoxide
alias d "z"
zoxide init fish | source

# Neovim
alias nv "nvim"

# fzf.fish
set fzf_fd_opts --hidden --exclude=.git
fzf_configure_bindings --directory=\cf --git_log=\cg --git_status=\cs

# Start tmux automatically
# if not set -q TMUX
#     eval tmux -f ~/.config/tmux/config new -s base
#     eval tmux a -t base
# end
