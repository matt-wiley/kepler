#!/bin/bash
set -euo pipefail  # Add strict error handling

KEPLER_HOME="$HOME/.config/kepler"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

INCLUDE_BASHRC_LEADER="$SCRIPT_DIR/.includes/bashrc_leader.sh"
INCLUDE_BASH_PROFILE_LEADER="$SCRIPT_DIR/.includes/bash_profile_leader.sh"
SCRIPT_INIT_DOTFILE_LINKS="$SCRIPT_DIR/init_dotfile_links.sh"

source "$SCRIPT_DIR/lib/kepler_tools.sh"

# Check for required files
required_files=(
    "$INCLUDE_BASHRC_LEADER"
    "$INCLUDE_BASH_PROFILE_LEADER"
    "$SCRIPT_INIT_DOTFILE_LINKS"
)

for file in "${required_files[@]}"; do
    if [[ ! -f "$file" ]]; then
        log "Error: Required file not found: $file"
        exit 1
    fi
done


# -----------------------------------------------------------------------------
#   Link kepler to user config directory
#
if [ -L "${KEPLER_HOME}" ]; then
    log "Kepler linkage already exists. Aborting to prevent overwriting."
    exit 0
else
    log "Linking kepler to user config directory."
    mkdir -p $(dirname $KEPLER_HOME)
    ln -s "$SCRIPT_DIR" "${KEPLER_HOME}"
fi


# -----------------------------------------------------------------------------
#   Create kepler bashrc
#
if [[ -f "$HOME/.bashrc" ]] && grep -q "KEPLER_HOME" "$HOME/.bashrc"; then
  log "Kepler bashrc has already been sourced."
else
  TEMP_BASHRC="bashrc.tmp"
  touch $TEMP_BASHRC

  cat $INCLUDE_BASHRC_LEADER >> $TEMP_BASHRC

  if [[ -f $HOME/.bashrc ]]; then
      cat $HOME/.bashrc >> $TEMP_BASHRC
      log "Backing up existing .bashrc to .bashrc.bak"
      mv $HOME/.bashrc $HOME/.bashrc.bak
  fi
  mv $TEMP_BASHRC $HOME/.bashrc
fi




# -----------------------------------------------------------------------------
#   Create kepler bash_profile
#

if [[ -f "$HOME/.bash_profile" ]] && grep -q "KEPLER_HOME" "$HOME/.bash_profile"; then
  log "Kepler bash_profile has already been sourced."
else
  TEMP_BASH_PROFILE="bash_profile.tmp"
  touch $TEMP_BASH_PROFILE

  cat $INCLUDE_BASH_PROFILE_LEADER >> $TEMP_BASH_PROFILE

  if [[ -f $HOME/.bash_profile ]]; then
      cat $HOME/.bash_profile >> $TEMP_BASH_PROFILE
      log "Backing up existing .bash_profile to .bash_profile.bak"
      mv $HOME/.bash_profile $HOME/.bash_profile.bak
  fi
  mv $TEMP_BASH_PROFILE $HOME/.bash_profile
fi


load $SCRIPT_INIT_DOTFILE_LINKS


# -----------------------------------------------------------------------------
#   Fin
#
log "Kepler environment configuration has been initialized."
