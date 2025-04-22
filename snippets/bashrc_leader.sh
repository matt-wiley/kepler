# -----------------------------------------------------------------------------
#   Source Kepler environment configuration
# -----------------------------------------------------------------------------

# Set the KEPLER_HOME environment variable to the default location if not already set
export KEPLER_HOME="${KEPLER_HOME:-$HOME/.config/kepler}"

if [[ -f "${KEPLER_HOME}/bashrc.sh" ]]; then
    source "${KEPLER_HOME}/bashrc.sh"
fi

# -----------------------------------------------------------------------------
#   Original bashrc contents at time of installation
# -----------------------------------------------------------------------------
