source "${KEPLER_HOME}/lib/kepler_tools.sh"

# ==============================================================================

# Source the arch-specific bashrc file
load "${KEPLER_HOME}/lib/arch/$(uname)/bashrc.sh"

# Source the core aliases
load "${KEPLER_HOME}/lib/aliases/core.sh"
