export PS1="\[\033[32m\]\h:\[\033[33;1m\]\W\[\033[m\] \$ "
export TERM=xterm-color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

export PATH=$PATH:$HOME/bin

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

alias console="php bin/console"
alias s.database.drop="php bin/console doctrine:database:drop"
alias s.database.create="php bin/console doctrine:database:create"
alias s.database.diff="php bin/console doctrine:migrations:diff"
alias s.database.migrate="php bin/console doctrine:migrations:migrate"
alias s.database.fixtures.load="php bin/console doctrine:fixtures:load"
alias s.routes="php bin/console debug:router"
alias s.container="php bin/console debug:container"
alias s.config="php bin/console config:dump-reference"
alias s.terminal="source /root/.bashrc"
alias s.cache.clear="php bin/console cache:clear --no-warmup --env=dev;php bin/console cache:clear --no-warmup --env=prod"


