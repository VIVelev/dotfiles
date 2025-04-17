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

# Setup tool aliases and configurations if they exist
function setup_tool
  set -l tool $argv[1]
  set -l setup_commands $argv[2..]
  
  if type -q $tool
    for cmd in $setup_commands
      eval $cmd
    end
  end
end

# Apply tool configurations
setup_tool rg "alias rg 'rg --color=always'"
setup_tool less "alias less 'less -R'"

setup_tool fzf "fzf --fish | source" \
          "set fzf_fd_opts --hidden --exclude=.git" \
          "fzf_configure_bindings --directory=\\cf --git_log=\\cg --git_status=\\cs"

setup_tool nvim "alias vim 'nvim'" \
           "alias vimdiff='nvim -d'" \
           "set -gx EDITOR nvim" \
           "set -gx VISUAL nvim"

setup_tool bat "alias cat 'bat'" \
           "set -gx MANPAGER \"sh -c 'col -bx | bat -l man -p'\""

setup_tool zoxide "alias d 'z'" \
             "zoxide init fish | source"

setup_tool direnv "direnv hook fish | source"
