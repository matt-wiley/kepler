# ==============================================================================
# Source specific bash_profile file based on the system architecture 
#
source "${KEPLER_HOME}/lib/uname/$(uname)/bash_profile.sh" || true

# ==============================================================================
#  Source the remaining configuration files if they exist
#
if [[ -f "$HOME/.profile" ]]; then
    source $HOME/.profile
fi
if [[ -f "$HOME/.bashrc" ]]; then
    source $HOME/.bashrc
fi

