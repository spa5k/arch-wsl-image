#!/bin/bash

# Check if script is run with root privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Please use sudo."
    exit 1
fi

# Prompt user for username
read -p "Enter your desired username: " NEW_USER

# Validate username
if [[ -z "$NEW_USER" ]]; then
    echo "Error: Username cannot be empty. Exiting."
    exit 1
fi

# Variables
SHELL="/bin/bash"

# Update system and install basic packages
echo "Updating system and installing basic packages..."
pacman -Syu --noconfirm
pacman -S --noconfirm sudo base-devel vim git wget curl

# Add new user
echo "Creating new user: $NEW_USER"
useradd -m -G wheel -s $SHELL $NEW_USER

# Set password for the new user
echo "Setting password for $NEW_USER..."
passwd $NEW_USER

# Allow wheel group to use sudo
echo "Configuring sudo for wheel group..."
sed -i '/%wheel ALL=(ALL:ALL) ALL/s/^# //' /etc/sudoers

# Enable bash shell for user in WSL
echo "Setting bash as the default shell for WSL..."
echo "[user]" >> /etc/wsl.conf
echo "default=$NEW_USER" >> /etc/wsl.conf

# Set startup script
echo "Configuring startup script..."

# Set timezone (Optional)
echo "Setting timezone..."
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
hwclock --systohc

# Install additional packages if needed
echo "Installing additional packages..."
pacman -S --noconfirm htop tmux zsh man-db neofetch reflector

# Set ZSH as default shell
echo "Setting ZSH as the default shell..."
chsh -s /bin/zsh $NEW_USER

# Success message
echo "User $NEW_USER created and basic packages installed!"
echo "Please restart your WSL instance for changes to take effect."