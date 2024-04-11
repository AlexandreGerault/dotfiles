#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias v='nvim'
alias vb='nvim ~/.bashrc'
alias vim='nvim'
alias cdp='cd ~/projects'
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias grep='rg'
PS1='[\u@\h \W]\$ '

export GPG_TTY=$(tty)
