config
======

It's like a briefcase for my configuration files.

Purpose
-------

This repository exists to help me do 3 things:
1. Track changes to my configuration files that I think will be useful across machines.
2. Set up a new "home" computer with minimal effort in a way that continues to let me track changes in this repository.
3. Set up an `ssh` configuration on a "home" machine in such a way that allows me to, from that home machine, automatically transfer and source configuration files onto remote machines without having to do anything on those remotes beforehand.

Requirements
------------

* openssh (with scp, required for sending configs to remote machines)
* gnu stow (not strictly required, but automates placing the symlinks to the configs)

Usage
-----

### Base Machine

1. Clone this repo to ~/config. Note that for `stow` to place the symlinks in the correct places, you MUST clone the repo into your home directory.
2. Copy ssh/.ssh/localconfig.template to ssh/.ssh/localconfig and fill it out appropriately. Note that your local version of the file will _not_ be under version control.
3. Do the same for ssh/.ssh/configcopy.sh.template, copying it to ssh/.ssh/configcopy.sh and adjusting it to your needs. Note that your local version of the file will _not_ be under version control.
4. `mkdir ~/.ssh/controlmasters` to create the expected directory to store the ssh sockets for re-use.
5. `cd` into the repo and run `stow [subdir]` for each set of configuration files you want symlinked to. You will want at least the ssh configs.

### Remote Machine

Nothing to do on remotes, just ssh into them and the configs you set up to be copied over in configcopy.sh will be there and already sourced for you!
Note: those configs are just copies, they are _not_ under version control on the remotes.
