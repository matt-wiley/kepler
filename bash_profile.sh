
if [[ -f "$HOME/.profile" ]]; then
    source $HOME/.profile
fi
if [[ -f "$HOME/.bashrc" ]]; then
    source $HOME/.bashrc
fi

export KEPLER_TEST_ONE="I'm from the bash profile"
