#!/bin/bash

# Initialize pacman keyring
pacman-key --init

# Add Chaotic AUR repository
pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
pacman-key --lsign-key 3056513887B78AEB
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' --noconfirm
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm
echo '[chaotic-aur]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/chaotic-mirrorlist' >> /etc/pacman.conf

# Update system
pacman -Syyu --noconfirm

# Install necessary packages
pacman -S --noconfirm sudo nano vim git base-devel wget curl glibc paru

# Configure WSL
echo "[boot]" > /etc/wsl.conf
echo "systemd=true" >> /etc/wsl.conf
touch /etc/machine-id
echo "%wheel        ALL=(ALL)       ALL" >> /etc/sudoers

# Clean up package cache to reduce image size
pacman -Scc --noconfirm
rm -rf /var/cache/pacman/pkg/* /tmp/*

# Remove /.dockerenv again (if necessary)
rm -f /.dockerenv
