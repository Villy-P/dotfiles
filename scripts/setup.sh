#!/bin/bash
set -euo pipefail

HOSTNAME=$(gum choose "archlinux" "homelab")

if [ ! -f /etc/pacman.conf.bak ]; then
    sudo cp /etc/pacman.conf /etc/pacman.conf.bak
fi
sudo sed -i '/#\[multilib\]/,+1 s/^#//' /etc/pacman.conf
sudo pacman -Syu --noconfirm
sudo pacman -S --needed - < ~/dotfiles/packages/$HOSTNAME/pacman.txt

if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git /tmp/yay-install
    cd /tmp/yay-install
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay-install
fi
yay -S --needed --noconfirm $(cat ~/dotfiles/packages/$HOSTNAME/aur.txt | grep -Ev "yay")

python3 ~/dotfiles/scripts/stow.py --host $HOSTNAME

chsh -s /usr/bin/zsh

sudo auto-cpufreq --install
if [[ "$HOSTNAME" == "archlinux" ]]; then
    curl -fsSL https://raw.githubusercontent.com/Brainitech/Brain_Shell/refs/heads/main/install.sh | bash
fi
