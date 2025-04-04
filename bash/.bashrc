# .bashrc
# Source bash_aliases
if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
fi

# Adjust history to my liking
HISTSIZE=10000
HISTFILESIZE=100000
HISTCONTROL=ignoreboth
HISTIGNORE='history:clear'
HISTTIMEFORMAT='%y-%m-%d %T '

# Set default editor
export EDITOR=nvim

# Enable the globstar recursive match feature of the shell
shopt -s globstar

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

if [ -f ~/.pyenv ]; then
	export PYENV_ROOT="$HOME/.pyenv"
	command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
fi

# Automatically start ssh-agent, but only once.
if [ -z "SSH_AUTH_SOCK" ] ; then
	eval $(ssh-agent -s)
	ssh-add
fi
# TODO: prevent buildup of ssh-agents each time I log in

# Set the default permissions for new files
umask 0002

# Create commands mark, marks, and unmark that act like vim marks for directories
export MARKPATH=$HOME/.marks
function jump { 
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark { 
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark { 
    rm -i "$MARKPATH/$1"
}
function marks {
    ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
