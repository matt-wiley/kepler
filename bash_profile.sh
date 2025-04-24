log() {
    if [[ -z "$KEPLER_HOME" ]]; then
        : # KEPLER_HOME not set, do not log
    else
        local logger_name=$(basename $BASH_SOURCE)
        local timestamp=$(date +'%Y-%m-%d %H:%M:%S.%3N')
        echo "[$timestamp] $logger_name : $*" >> "$KEPLER_HOME/${logger_name/.sh/.log}"
    fi
}

load() {
    local file="$1"
    if [[ -f "$file" ]]; then
        log "Sourcing $file"
        source "$file" 2>&1 > /dev/null || {
            log "Error sourcing $file"
        }
    fi
}

# ==============================================================================

# Source the arch-specific bash_profile file 
load "${KEPLER_HOME}/lib/arch/$(uname)/bash_profile.sh"

#  Source the remaining configuration files
load "$HOME/.profile"
load "$HOME/.bashrc"

