#!/bin/bash
set -euo pipefail

if [ ! -f /etc/pacman.conf.bak ]; then
    sudo cp /etc/pacman.conf /etc/pacman.conf.bak
fi
sudo sed -i '/#\[multilib\]/,+1 s/^#//' /etc/pacman.conf
sudo pacman -Syu --noconfirm
sudo pacman -S --needed - < ~/dotfiles/packages/pacman.txt

if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git /tmp/yay-install
    cd /tmp/yay-install
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay-install
fi
yay -S --needed --noconfirm $(cat ~/dotfiles/packages/aur.txt | grep -Ev "yay")

while read -r extension; do
    code --install-extension "$extension"
done < ~/dotfiles/packages/vscode.txt

stow ~/dotfiles/git
stow ~/dotfiles/hypr
stow ~/dotfiles/kitty
stow ~/dotfiles/millennium
stow ~/dotfiles/rofi
stow ~/dotfiles/waybar
stow ~/dotfiles/wpaperd
stow ~/dotfiles/zsh
stow ~/dotfiles/btop
stow ~/dotfiles/code
stow ~/dotfiles/calcure

chsh -s /usr/bin/zsh

mkdir -p ~/pictures
curl -o ~/pictures/wallpaper.jpg https://images.unsplash.com/photo-1464822759023-fed622ff2c3b