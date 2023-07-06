USER ?= vivelev

# Setup Homebrew
brew:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | /bin/bash

# Stow the configs
stow:
	stow -t /Users/$(USER)/ -R \
		fd/ \
		git/ \
		fish/ \
		nvim/ \
		kitty/ \
		atuin/ \
		ipython/
	atuin import auto  # Setup atuin
