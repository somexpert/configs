# Copy over bash aliases (add whatever other files you want to copy as additional commands after this one)
scp -o ControlPath="$1" ~/.bash_aliases servexpert:~/.bash_aliases &> ~/.ssh/configcopy_out.txt &
# Leave some time before saying the configs have been copied over, since the transfers are backgrounded
sleep 0.2
echo "Configs copied over via LocalCommand (.ssh/[config|localconfig|configcopy.sh])
