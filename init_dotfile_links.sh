#!/bin/bash

# This script creates symbolic links for dotfiles in the user's home directory.
# 
# It can be rerun as needed to pick up new dotfiles. Changes to existing 
# dotfiles that have already been linked will not be overwritten.
#
# It uses the KEPLER_HOME environment variable to determine the source of the 
# dotfiles.
# 
# If KEPLER_HOME is not set, it runs in dry run mode, printing the commands 
# instead of executing them.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/kepler_tools.sh"

update_dotfile_links() {
    local kepler_home="${KEPLER_HOME:-"KEPLER_HOME"}"

    local link_map=(
        ".vimrc|lib/vimrc/amix-basic.vimrc"
    )

    local dry_run=false
    if [[ "$kepler_home" == "KEPLER_HOME" ]]; then
        dry_run=true
        echo "<!> KEPLER_HOME is not set. Running in dry run mode."
    fi

    for file in "${link_map[@]}"; do
        local target="${file%%|*}"
        local source="${file#*|}"
        if [[ "$dry_run" == true ]]; then
            echo ln -s "$kepler_home/$source" "$HOME/$target"
        else
            ln -s "$kepler_home/$source" "$HOME/$target"
        fi
         log "Linked $source to $target"
    done

    unset -f update_dotfile_links
}
update_dotfile_links
