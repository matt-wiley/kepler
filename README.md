# kepler

Common dotfile and bash configuration management for macOS and Linux.

## Principles

### "Gotta keep 'em separated"

Dotfiles are managed in a separate directory with version control to track their history. A one-time initialization script sets up the environment by injecting source commands into shell configuration files like .bashrc and .bash_profile. This ensures consistent common configurations across all Bash environments while allowing users to maintain machine-specific settings in their individual configuration files.


