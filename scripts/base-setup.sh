#!/bin/bash -eu

if [ "$(id -u)" -ne 0 ]; then
        echo 'This script must be run by root' >&2
        exit 1
fi

apt purge -y gnome-games transmission-gtk zutty
apt autoremove --purge -y
apt install -y systemd-zram-generator
systemctl daemon-reload
apt install -y systemd-oomd
apt install -y ttf-mscorefonts-installer
apt install -y flatpak
apt install -y gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
# apt install -y neofetch
# wget -P /tmp https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
# apt install -y /tmp/google-chrome-stable_current_amd64.deb
# rm /tmp/google-chrome-stable_current_amd64.deb
apt install -y unrar
