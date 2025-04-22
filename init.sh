#!/bin/bash

# -----------------------------------------------------------------------------
#   Link kepler to user config directory
#
KEPLER_HOME="$HOME/.config/kepler"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Link kepler to user config directory
if [ -L "${KEPLER_HOME}" ]; then
    echo "Kepler linkage already exists."
    echo "Aborting to avoid overwriting."
    exit 0
else
    echo "Linking kepler to user config directory."
    mkdir -p $(dirname $KEPLER_HOME)
    ln -s "$SCRIPT_DIR" "${KEPLER_HOME}"
fi


# -----------------------------------------------------------------------------
#   Create kepler bashrc
#
TEMP_BASHRC="bashrc.tmp"
touch $TEMP_BASHRC

cat $SCRIPT_DIR/includes/bashrc_leader.sh >> $TEMP_BASHRC

if [[ -f $HOME/.bashrc ]]; then
    cat $HOME/.bashrc >> $TEMP_BASHRC
    echo "Backing up existing .bashrc to .bashrc.bak"
    mv $HOME/.bashrc $HOME/.bashrc.bak
fi
mv $TEMP_BASHRC $HOME/.bashrc


# -----------------------------------------------------------------------------
#   Create kepler bash_profile
#
TEMP_BASH_PROFILE="bash_profile.tmp"
touch $TEMP_BASH_PROFILE

cat $SCRIPT_DIR/includes/bash_profile_leader.sh >> $TEMP_BASH_PROFILE

if [[ -f $HOME/.bash_profile ]]; then
    cat $HOME/.bash_profile >> $TEMP_BASH_PROFILE
    echo "Backing up existing .bash_profile to .bash_profile.bak"
    mv $HOME/.bash_profile $HOME/.bash_profile.bak
fi
mv $TEMP_BASH_PROFILE $HOME/.bash_profile

# -----------------------------------------------------------------------------
#   Fin
#
echo "Kepler environment configuration has been initialized."
