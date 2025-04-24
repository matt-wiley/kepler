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

# Source the arch-specific bashrc file
load "${KEPLER_HOME}/lib/arch/$(uname)/bashrc.sh"

# Source the core aliases
load "${KEPLER_HOME}/lib/aliases/core.sh"
