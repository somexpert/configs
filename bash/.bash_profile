# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
if [ -f ~/.pyenv ]; then
	export PYENV_ROOT="~/.pyenv";
	command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH";
	eval "$(pyenv init -)";
fi
