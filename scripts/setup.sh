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

cd ~/dotfiles
stow git
stow hypr
stow kitty
stow rofi
stow zsh
stow btop
stow code
stow quickshell
stow matugen

mkdir -p ~/.config/matugen/templates
mkdir -p ~/.local/state/quickshell/generated

chsh -s /usr/bin/zsh

mkdir -p ~/pictures
curl -o ~/pictures/wallpaper/wallpaper.jpg https://images.unsplash.com/photo-1464822759023-fed622ff2c3b