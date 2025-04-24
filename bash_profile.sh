source "${KEPLER_HOME}/lib/kepler_tools.sh"

# ==============================================================================

# Source the arch-specific bash_profile file 
load "${KEPLER_HOME}/lib/arch/$(uname)/bash_profile.sh"

#  Source the remaining configuration files

if [[ -f "$HOME/.profile" ]]; then
    load "$HOME/.profile"
else
    log "No .profile file found in $HOME"
fi
if [[ -f "$HOME/.bashrc" ]]; then
    load "$HOME/.bashrc"
else
    log "No .bashrc file found in $HOME"
fi

