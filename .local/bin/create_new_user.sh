#!/usr/bin/env zsh


printf "Enter password: "; read -s pw0
printf "\nRetype password: "; read -s pw1
while ! [ "$pw0" = "$pw1" ]; do
    printf "\nPasswords do not match."
    printf "\nEnter password: "; read -s pw0
    printf "\nRetype password: "; read -s pw1
done
echo

useradd -m -G wheel sudo -s /bin/zsh user
echo "user:$pw0" | chpasswd
