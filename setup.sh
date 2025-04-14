# Create the controlmasters directory
if [ ! -d ~/.ssh/controlmasters ]; then
	echo "Creating ~/.ssh/controlmasters directory for socket sharing..."
	mkdir -p ~/.ssh/controlmasters
fi
# Create local ssh config and script from templates, prompting for required values
if ! [ -f configs/ssh_localconfig ]; then
	read -p "Create ssh_localconfig file from template? (y/n): " SSH_LOCALCONFIG_CONSENT
	if [ "$SSH_LOCALCONFIG_CONSENT" == "y" ]; then
		read -p "Please enter the remote user you want to limit config syncing to (can be adjusted later in the ssh_localconfig file): " USER
		sed "s/Match user \[username\]/Match user $USER/" configs/ssh_localconfig.template > configs/ssh_localconfig
	fi
fi
if ! [ -f configs/copyconfigs.sh ]; then
	read -p "Create copyconfigs.sh file from template? (y/n): " COPYCONFIGS_CONSENT
	if [ "$COPYCONFIGS_CONSENT" == "y" ]; then
		# TODO: should there be a better way of figuring out which files to sync? Maybe another header?
		# If I change to the header method, I'll no longer need to have a template and copy it over here.
		read -p "Provide a list of paths, separated by a space and each path starting with '~/', for the files you want to be sync'd to remote servers when ssh-ing into them: " CONFIG_LIST
		sed "s/\[config_file_list\]/$CONFIG_LIST/" configs/copyconfigs.sh.template > configs/copyconfigs.sh
	fi
fi
# Symlink the files (creating backups if needed) if the user wants
read -p "Create symlinks for configs? (y/n): " SYMLINK_CONSENT
if [ "$SYMLINK_CONSENT" == "y" ]; then
	for CONFIG_FILE in configs/* ;
	do
		if [[ ! $CONFIG_FILE == *".template" ]]; then
			# Get filename and directory from file headers
			FILENAME=$(grep "# Filename: " $CONFIG_FILE | cut -d ' ' -f 3)
			DIR_STRING=$(grep "# Directory: " $CONFIG_FILE | cut -d ' ' -f 3)
			# Manually expand the tilde to the home directory
			DIR="${DIR_STRING/#\~/$HOME}"
			if [[ -n $DIR ]] && [[ -n "$FILENAME" ]]; then
				# Create directory (and parents) if needed
				if [ ! -d $DIR ]; then
					mkdir -pv $DIR
				fi
				# Backup file if needed (with .bak suffix) then create symlink
				echo "Creating symlink for $FILENAME"
				if [[ -L $DIR/$FILENAME ]]; then
					echo "$DIR/$FILENAME is already a symlink, skipping."
				else
					if [[ -f $DIR/$FILENAME ]]; then
						echo "Backing up existing file at $DIR/$FILENAME before creating symlink."
						mv $DIR/$FILENAME $DIR/$FILENAME.bak
					fi
					ln -s $(pwd)/$CONFIG_FILE $DIR/$FILENAME
				fi
			else
				echo "$FILENAME is missing required headers for filename and/or directory. Ignoring."
			fi
		fi
	done
else
	echo "Skipped creating symlinks."
fi
echo "Done!"
