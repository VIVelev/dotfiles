export PATH="/opt/homebrew/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="lambda"

plugins=(git
         fzf
         macos
         direnv
         zoxide
         nix-shell
         zsh-syntax-highlighting)

export FZF_BASE=~/.nix-profile/bin/fzf

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

alias ls="exa -la --color=always --color-scale --git --sort=Name"
alias d="z"
alias umba="micromamba"

# Neovim for vim
if command -v "nvim" > /dev/null; then
  alias vim="nvim"
  alias vimdiff="nvim -d"
  export EDITOR="nvim"
  export VISUAL="nvim"
fi

# Bat for cat
if command -v "bat" > /dev/null; then
  alias cat="bat"
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE="/Users/vivelev/.nix-profile/bin/micromamba";
export MAMBA_ROOT_PREFIX="/Users/vivelev/micromamba";
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    if [ -f "/Users/vivelev/micromamba/etc/profile.d/micromamba.sh" ]; then
        . "/Users/vivelev/micromamba/etc/profile.d/micromamba.sh"
    else
        export  PATH="/Users/vivelev/micromamba/bin:$PATH"  # extra space after export prevents interference from conda init
    fi
fi
unset __mamba_setup
# <<< mamba initialize <<<
