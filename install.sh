#!/bin/bash

# Symlinks a file, but prompts the user if the file already exists.
# Expected arguments:
#   $1 = link from; source
#   $2 = link to; target
function maybe_symlink {
    # If target exists as a file or symbolic
    # link, then prompt for replacement
    if [ -e "$2" ] || [ -h "$2" ]; then
        echo -n "Backup and replace '$2'? (y/n) "
        read answer
        if [ "$answer" = "y" ]; then
            echo "Okay...moving it to '$2.bak'"
            mv "$2" "$2.bak"

            echo "Linking '$1' to '$2'..."
            ln -s "$1" "$2"
        else
            echo "Fine, leaving it alone...things might not work right though"
        fi

    else
        echo "Linking '$1' to '$2'..."
        ln -s "$1" "$2"
    fi
    echo # newline
}

# Symlinks all files from lib/ into ~/
function install_dotfiles {
    for dotfile in $PWD/lib/*; do
        destination="$HOME/.$(basename $dotfile)"
        maybe_symlink $dotfile $destination
    done
}

install_dotfiles
