
log() {
    local logger_name=$(basename $BASH_SOURCE)
    local bash_source_dir=$(dirname $BASH_SOURCE)
    local timestamp=$(date +'%Y-%m-%d %H:%M:%S.%3N')
    echo "[$timestamp] $logger_name : $*" >> "$bash_source_dir/${logger_name/.sh/.log}"
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