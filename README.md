# kepler

Common dotfile and bash configuration management for macOS and Linux.

## Principles

### "Gotta keep 'em separated"

Dotfiles are managed in a separate directory with version control to track their history. 

A one-time initialization script sets up the environment by injecting source commands into shell configuration files like `~/.bashrc` and `~/.bash_profile`. This ensures consistent common configurations across all Bash environments while allowing users to maintain machine-specific settings in their individual configuration files.


## Files

### Core Files for Shell Configuration

- `bashrc.sh`: Common Bash configuration file for interactive shells.
- `bash_profile.sh`: Common Bash configuration file for login shells.
- `init.sh`: One-time initialization script that sets up the environment.
- `includes/*`: Directory containing sub-scripts and snippets included during the initialization process. 

### Support Files for Development

- `dev.Dockerfile`: Dockerfile for building a development environment.
- `docker-compose.yml`: Docker Compose file for running the development environment.
- `env.sh`: Environment helpers for development.

## Development Flow

The process is mostly just BASH scripting. Nothing new there.

You can use the Dockerfile and docker-compose.yml to build a development or testing environment to test fresh installations as needed.

### The Long Version

Asssuming you have the `env.sh` file sourced in your local dev terminal, the general flow is as follows: 

1. Make changes to files in the repo
2. Tear down the existing Docker container (`down`)
3. Build and run the updated Docker container with your changes (`up`)
4. SSH into the container (`connect`)
5. Login as `frodo` (the password is `ringbearer`)
6. `cd` into the `~/repospace/kepler` directory
7. Run the `init.sh` script to set up the environment

At this point you have a fresh ubuntu environment with the latest changes to the dotfiles. You can test your changes and make sure everything works as expected.

8. `logout` of the container
9. SSH back into the container (`connect`)

At this point you should be in a login shell with the latest changes loaded up.

### The  Short Version

1. Make changes
2. `bounce` the container
3. `connect` to the container
4. Init `kepler` 
5. `logout` and `connect` again
6. Test your changes
