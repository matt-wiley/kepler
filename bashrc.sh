# Source specific bashrc file based on the system architecture
source "${KEPLER_HOME}/lib/uname/$(uname)/bashrc.sh" || true
