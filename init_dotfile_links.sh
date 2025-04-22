


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
        echo "Linked $source to $target"
    done

    unset -f update_dotfile_links
}
update_dotfile_links
