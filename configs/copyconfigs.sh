# Filename: copyconfigs.sh
# Directory: ~/.ssh/

# TODO: get list of configs dynamically from a special comment line in each config file
while read CONFIG; do
  if [[ ! $CONFIG == \#* ]] && [[ ! -z $CONFIG ]] ; then
	EXPANDED_CONFIG_PATH="${CONFIG/#\~/$HOME}"
	# TODO: solve issue of missing parent directories on remote.
	scp -o ControlPath=$2 $EXPANDED_CONFIG_PATH $1:$CONFIG &>> ~/.ssh/copyconfigs_out.txt &
  fi
done < ./configs_to_sync.txt
# Leave some time before saying the configs have been copied over, since the transfers are backgrounded
sleep 0.2
echo "Configs copied over via scp on shared socket."
