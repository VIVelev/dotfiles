# Git aliases
alias ga="git add"
alias gaa="git add --all"
alias gst="git status"
alias glg="git log --graph"
alias gcm="git commit -m"
alias gb="git branch"
alias gco="git checkout"
alias gd="git diff"
alias gds="git diff --stat"
alias gl="git pull"
alias gp="git push"

alias ll="ls -lG"

setopt SHARE_HISTORY
autoload -Uz compinit && compinit

fg-and-execute() {
  fg
  zle accept-line
}
zle -N fg-and-execute
bindkey '^o' fg-and-execute

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line

# Homebrew setup for macOS
if [[ "$(uname)" == "Darwin" ]]; then
  if [[ -z "$HOMEBREW_PREFIX" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

# Setup tool aliases and configurations if they exist
setup_tool() {
  local tool="$1"
  shift
  local setup_commands=("$@")

  if command -v "$tool" &> /dev/null; then
    for cmd in "${setup_commands[@]}"; do
      eval "$cmd"
    done
  fi
}

setup_tool "nvim" \
  "alias vim='nvim'" \
  "alias vimdiff='nvim -d'" \
  "export EDITOR='nvim'" \
  "export VISUAL='nvim'"
setup_tool "bat" \
  "alias cat='bat'" \
  "export MANPAGER=\"sh -c 'col -bx | bat -l man -p'\""
setup_tool "uv" \
  "$(uv generate-shell-completion zsh)"
setup_tool "fzf" \
  "source <(fzf --zsh)"
