# Connectivity info for Linux VM
NIXADDR ?= unset
NIXPORT ?= 22
NIXUSER ?= vivelev

# The block device prefix to use
NIXBLOCKDEVICE ?= sda

# SSH options used
SSH_OPTS =-o PubkeyAuthentication=no -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no

# Stow the configs
stow:
	stow -t /home/$(NIXUSER)/ -R \
		i3/ \
		fd/ \
		git/ \
		xorg/ \
		fish/ \
		nvim/ \
		atuin/ \
		kitty/ \
		ipython/ \

# Bootstrap the NixOS VM
vm/bootstrap:
	ssh $(SSH_OPTS) -p$(NIXPORT) root@$(NIXADDR) " \
		parted /dev/$(NIXBLOCKDEVICE) -- mklabel gpt; \
		parted /dev/$(NIXBLOCKDEVICE) -- mkpart primary 512MiB -8GiB; \
		parted /dev/$(NIXBLOCKDEVICE) -- mkpart primary linux-swap -8GiB 100\%; \
		parted /dev/$(NIXBLOCKDEVICE) -- mkpart ESP fat32 1MiB 512MiB; \
		parted /dev/$(NIXBLOCKDEVICE) -- set 3 esp on; \
		mkfs.ext4 -L nixos /dev/$(NIXBLOCKDEVICE)1; \
		mkswap -L swap /dev/$(NIXBLOCKDEVICE)2; \
		mkfs.fat -F 32 -n boot /dev/$(NIXBLOCKDEVICE)3; \
		mount /dev/disk/by-label/nixos /mnt; \
		mkdir -p /mnt/boot; \
		mount /dev/disk/by-label/boot /mnt/boot; \
		nixos-generate-config --root /mnt; \
		sed --in-place '/system\.stateVersion = .*/a \
			services.openssh.enable = true;\n \
			services.openssh.passwordAuthentication = true;\n \
			services.openssh.permitRootLogin = \"yes\";\n \
			users.users.root.initialPassword = \"root\";\n \
		' /mnt/etc/nixos/configuration.nix; \
		nixos-install --no-root-passwd; \
		reboot; \
	"

# Run this after vm/bootstrap to finalize.
vm/migrate:
	NIXUSER=root $(MAKE) vm/copy-nixos
	NIXUSER=root $(MAKE) vm/switch

# copy the nixos configuration over to the VM
vm/copy-nixos:
	rsync -av -e "ssh $(SSH_OPTS) -p$(NIXPORT)" \
		--exclude='.git/' \
		--rsync-path="sudo rsync" \
		/Users/vivelev/dotfiles/nixos/ $(NIXUSER)@$(NIXADDR):/my-nixos/

vm/switch:
	ssh $(SSH_OPTS) -p$(NIXPORT) $(NIXUSER)@$(NIXADDR) " \
		sudo cp -f /my-nixos/configuration.nix /etc/nixos/; \
		sudo nixos-rebuild switch; \
		sudo reboot; \
	"
