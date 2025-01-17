set -gx LANG en_US.UTF-8
set -gx PAGER "less -FirSwX"
set -gx fish_greeting ""

fish_config theme choose fish\ default

# git alias
alias ga "git add"
alias gaa "git add --all"
alias gst "git status"
alias gcm "git commit -m"

alias gb "git branch"
alias gco "git checkout"

alias gd "git diff"
alias gds "git diff --stat"

alias gl "git pull"
alias gp "git push"

bind \ca "fg && commandline -f execute"

if test (uname) = Darwin
  # Homebrew setup
  if test -z "$HOMEBREW_PREFIX"
      eval (/opt/homebrew/bin/brew shellenv)
  end
end

# Grep with color
if type -q rg
  alias rg "rg --color=always"
end

# Less with color
alias less "less -R"

# Fzf
if type -q fzf
  fzf --fish | source

  set fzf_fd_opts --hidden --exclude=.git
  fzf_configure_bindings --directory=\cf --git_log=\cg --git_status=\cs
end

# Neovim
if type -q nvim
  alias vim "nvim"
  alias vimdiff="nvim -d"
  set -gx EDITOR nvim
  set -gx VISUAL nvim
end

if type -q bat
  alias cat "bat"
  set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
end

if type -q zoxide
  # Zoxide
  alias d "z"
  zoxide init fish | source
end

if type -q direnv
  # Direnv
  direnv hook fish | source
end
