# -----------------------------------------------------------------------------
#   Source Kepler environment configuration
# -----------------------------------------------------------------------------

# Set the KEPLER_HOME environment variable to the default location if not already set
export KEPLER_HOME="${KEPLER_HOME:-$HOME/.config/kepler}"

if [[ -f "${KEPLER_HOME}/bash_profile.sh" ]]; then
    source "${KEPLER_HOME}/bash_profile.sh"
fi

# -----------------------------------------------------------------------------
#   Original bash_profile contents at time of installation
# -----------------------------------------------------------------------------




