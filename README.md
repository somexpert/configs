config
======

It's like a briefcase for my configuration files.

Purpose
-------

This repository exists to help me do 3 things:
1. Track changes to my configuration files that I think will be useful across machines.
2. Set up a new "home" computer with minimal effort in a way that continues to let me track changes in this repository.
3. Set up an `ssh` configuration on a "home" machine in such a way that allows me to, from that home machine, automatically transfer and source configuration files onto remote machines without having to do anything on those remotes beforehand.


Usage
-----

### Base Machine

1. Clone this repo to a location of your choosing on your base machine.
2. Optionally, remove configs that don't apply to you and add missing ones that do. The only requirement for them to get
   symlinked automatically by the setup script (next step) is for them to have two commented lines showing the intended
   destination filename and containing directory. They _must_ have the expected structure, shown below, even if you must
   prepend a different comment character before the hash.
   ex. "# Filename: [filename]"
       "# Directory: [dir]"
3. Run the setup.sh script. Note: the script can be run multiple times if needed, such as after adding a new config file.
4. Optionally, adjust which configuration files you want to be synced, and when/where, by modifying the
   configs_to_copy.txt and ssh_localconfig files, respectively.

### Remote Machine

Nothing to do on remotes, just ssh into them and the configs you set up to be copied over in configcopy.sh will be there and already sourced for you!
Note: those configs are just copies, they are _not_ under version control on the remotes.
