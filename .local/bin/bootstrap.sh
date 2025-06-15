#!/usr/bin/env zsh


# This script installs all packages for my setup


error() {
    printf "Error: $1\n" >&2; exit 1
}

# FIX: 
gitmakeinstall() {
	username="${1##*/}"
	repo="${dir%.git}"
	dir="$user/$repo"
    echo  $dir
    return 0
	sudo -u "$name" git -C "$repodir" clone --depth 1 --single-branch \
		--no-tags -q "$1" "$dir" ||
		{
			cd "$dir" || return 1
			sudo -u "$name" git pull --force origin master
		}
	cd "$dir" || exit 1
	make >/dev/null 2>&1
	make install >/dev/null 2>&1
	cd /tmp || return 1
}


if id -u &>/dev/null ;then
    error "You must run this script as root"
fi

# enable parallel downloads
sed -Ei "s/^#(ParallelDownloads).*/\1 = 5/;/^#Color$/s/#//" /etc/pacman.conf

# The arch linux keyring is the package which contains the GPG keys of trusted package maintainers
echo "Refreshing keyring"
pacman --noconfirm --needed -S  archlinux-keyring ||  error "Could not refresh keyring"

# NOTE: removed git from this list  since the repo has probably been cloned already
pacman --noconfirm --needed -S curl ca-certificates base-devel zsh sudo || error "Failed to install required packages"


# Use all cores for compilation
sed -i "s/-j2/-j$(nproc)/;/^#MAKEFLAGS/s/^#//" /etc/makepkg.conf


# yay bootstrap check 
# Check if yay is already installed, if not, clone the repo and install it
if ! command yay --version &>/dev/null; then
    git clone https://aur.archlinux.org/yay.git ~/repos/yay || error "failed to clone yay"
    cd ~/repos/yay
    makepkg -si
    cd -
fi


# Run the sync_packages script which downloads all packages using pacman and yay
./sync_packages.sh
