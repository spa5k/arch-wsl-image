#!/bin/bash

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Initialize pacman keyring
echo "Initializing pacman keyring..."
pacman-key --init || { echo "Failed to initialize pacman keyring"; exit 1; }

# Add Chaotic AUR repository
echo "Adding Chaotic AUR repository..."
pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com || { echo "Failed to receive key"; exit 1; }
pacman-key --lsign-key 3056513887B78AEB || { echo "Failed to locally sign key"; exit 1; }
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' --noconfirm || { echo "Failed to install chaotic-keyring"; exit 1; }
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm || { echo "Failed to install chaotic-mirrorlist"; exit 1; }

# Add Chaotic AUR to pacman configuration
echo "Configuring pacman..."
echo '[chaotic-aur]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/chaotic-mirrorlist' >> /etc/pacman.conf

# Update system
echo "Updating system..."
pacman -Syyu --noconfirm || { echo "Failed to update system"; exit 1; }

# Install necessary packages
echo "Installing necessary packages..."
pacman -S --noconfirm sudo nano vim git wget curl glibc paru htop net-tools openssh zsh neofetch powerpill reflector || { echo "Failed to install packages"; exit 1; }

# Configure WSL
echo "Configuring WSL..."
echo "[boot]" > /etc/wsl.conf
echo "systemd=true" >> /etc/wsl.conf
touch /etc/machine-id
echo "%wheel        ALL=(ALL)       ALL" >> /etc/sudoers

# Set up Zsh and Zinit
echo "Setting up Zsh and Zinit..."
chsh -s /bin/zsh

# Clean up package cache to reduce image size
echo "Cleaning up package cache..."
pacman -Scc --noconfirm || { echo "Failed to clean package cache"; exit 1; }
rm -rf /var/cache/pacman/pkg/* /tmp/*

# Remove /.dockerenv again (if necessary)
echo "Removing /.dockerenv if exists..."
rm -f /.dockerenv

echo "Setup completed successfully!"
