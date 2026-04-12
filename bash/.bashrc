#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

PS1='[\u@\h \W]\$ '

export GPG_TTY=$(tty)

if command -v kitty >/dev/null 2>&1; then
    export TERM="xterm-kitty"
fi

