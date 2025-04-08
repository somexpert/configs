# Bash aliases

alias sudo='sudo '
alias ssh-start='eval "$(ssh-agent)" ; ssh-add'
if command -v nvim 2>&1 >/dev/null
then
	alias vim=nvim
fi
alias aliases='vim ~/.bash_aliases ; source ~/.bash_aliases'
alias ls='ls --color=auto'
alias la='ls -Alh'
alias ll='ls -lh'
alias rm='rm -I --preserve-root -d -v'
alias dc='docker compose'
alias dcr='docker compose run --rm'
alias ppath='export PYTHONPATH=$(pwd)'
alias grep='grep --color=auto -I --exclude-dir=.tox --exclude-dir=__pycache__ --exclude-dir=/static'
alias pygrep='grep -RI --exclude-dir=".*" --include="*.py"'
alias tempgrep='grep -RI --exclude-dir=".*" --include="*.html"'
alias flake8='flake8 --max-line-length=99'
