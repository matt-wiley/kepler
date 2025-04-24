
_passthru_logger() { ## INTERNAL FUNCTION
    #
    # THIS FUNCTION IS FOR INTERNAL USE ONLY. IT IS NOT INTENDED FOR USE BY
    # CLIENT SCRIPTS.
    #
    # This function is used to log messages to a file in the same directory as 
    # the script that called a kepler_tools function. The log file is named 
    # after the script that called the function, with a ".log" extension.
    #
    local caller="${1}"  
    shift
    local logger_name=$(basename "${caller}")
    local bash_source_dir="$(cd $(dirname "${caller}") && pwd)"
    local timestamp=$(date +'%Y-%m-%d %H:%M:%S.%3N')
    echo "[$timestamp] $logger_name : $*" >> "$bash_source_dir/${logger_name/.sh/.log}"
}

# ==============================================================================


log() {
    #
    # This function is used to log messages to a file in the same directory as
    # the script that called a kepler_tools function. The log file is named
    # after the script that called the function, with a ".log" extension.
    #
    local caller="${BASH_SOURCE[1]}"
    local logger_name=$(basename "${caller}")
    local bash_source_dir="$(cd $(dirname "${caller}") && pwd)"
    local timestamp=$(date +'%Y-%m-%d %H:%M:%S.%3N')
    echo "[$timestamp] $logger_name : $*" >> "$bash_source_dir/${logger_name/.sh/.log}"
}

load() {
    #
    # This function is used to load a file into the current shell session.
    # It checks if the file exists and is a regular file before sourcing it.
    # If the file is not found, it logs an error message.
    #
    # Arguments:
    #   $1: The file to load.
    #
    local caller="${BASH_SOURCE[1]}"
    local file="$1"
    if [[ -f "$file" ]]; then
        _passthru_logger "$caller" "Sourcing $file"
        source "$file" 2>&1 > /dev/null || {
            _passthru_logger "$caller" "Error sourcing $file"
        }
    fi
}