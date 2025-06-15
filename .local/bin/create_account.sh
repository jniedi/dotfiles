#!/usr/bin/env zsh

# Prompts for username, email, confirmation etc.




die(){
    echo "Aborted"
    exit 1
}

email=$(cat ~/documents/email/addresses.md | gum choose --header "Choose email: " --no-show-help)
username=$(gum input --no-show-help --placeholder 'Enter username')


while ! gum confirm --no-show-help "Use '$(xclip -o)' as url?"; do
    printf "Copy the url and press enter "
    read
    printf "\033[1A"    # Move cursor up one line
    printf "\033[2K"    # Clear the entire line
done
url=$(xclip -o)



echo "Selected:
email:      $email
username:   $username
url:	    $url
"
gum confirm --no-show-help "Proceed with password generation?"  || die

# Critical part, handles passwords.
pass list

# Where the password will be stored
filename=$(gum input --no-show-help --placeholder 'Enter filename')

gum confirm --no-show-help "Con"  || die


# vim: ft=bash
