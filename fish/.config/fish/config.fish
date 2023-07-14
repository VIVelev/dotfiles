set -gx LANG en_US.UTF-8
set -gx PAGER "less -FirSwX"
set -gx fish_greeting ""

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

if test (uname) = Darwin
  # Homebrew setup
  if test -z "$HOMEBREW_PREFIX"
      eval (/opt/homebrew/bin/brew shellenv)
  end
end

# Exa (ls in Rust) alias
alias ls "exa -la --color=always --color-scale --git --sort=Name"

# Grep with color
alias rg "rg --color always"
alias grep "rg"

# Less with color
alias less "less -R"

# Micrmomamba
alias mamba "micromamba"

# IPython
set -x IPYTHONDIR ~/.config/ipython/

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

if status is-interactive
    # Zoxide
    alias d "z"
    zoxide init fish | source

    # Atuin
    set -x ATUIN_NOBIND "true"
    atuin init fish | source
    bind \cr _atuin_search

    # Direnv
    direnv hook fish | source
end

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
set -gx MAMBA_EXE "/opt/homebrew/bin/micromamba"
set -gx MAMBA_ROOT_PREFIX "/Users/vivelev/micromamba"
$MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
# <<< mamba initialize <<<
