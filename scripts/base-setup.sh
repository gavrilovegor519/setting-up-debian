#!/bin/sh
apt purge -y gnome-games gnome-remote-desktop transmission-gtk zutty
apt autoremove --purge -y
apt install -y systemd-zram-generator
systemctl daemon-reload
apt install systemd-oomd
apt install -y ttf-mscorefonts-installer
# apt install -y neofetch
wget -P /tmp https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install -y /tmp/google-chrome-stable_current_amd64.deb
rm /tmp/google-chrome-stable_current_amd64.deb
apt install unrar