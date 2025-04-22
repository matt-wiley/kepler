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
- `init_dotfile_links.sh`: Script that creates symlinks to the dotfiles in the home directory.
- `.includes/*`: Directory containing sub-scripts and snippets included during the initialization process. 
- `lib`: All supporting functions and libraries for the dotfiles. This is where the magic happens. 

#### `lib` Directory

Generally speaking this directory contains subdirectories for each of the major components of the dotfiles. Each configuration file gets its own subdirectory to organize the files, but there is no hard and fast rule about how the subdirectories are structured.

- `uname`: Contains folders for each OS type (Linux, Darwin, etc.) with configuration files that that are OS-specific.
- `vimrc`: Collection of vimrc files.


#### `init_dotfile_links.sh`

This script creates symlinks to the dotfiles in the home directory. It is run by the `init.sh` script to set up the environment. 

As changes are made to the dotfiles, this script can be run to update the symlinks in the home directory. The `link_map` variable in the script contains a list of files to be linked, with the format `link_target|link_source`. Where `link_target` is the path to the file in the home directory that should be created (e.g. `.vimrc`) and `link_source` is the path to the file in the repository that contains the configuration (e.g. `lib/vimrc/amix-basic.vimrc`).

```bash
update_dotfile_links() {
  # ...
  local link_map=(
      ".vimrc|lib/vimrc/amix-basic.vimrc"
  )
  # ...
}
```


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
