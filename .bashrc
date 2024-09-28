#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip -color=auto'
alias cal='cal --monday'
alias locate=plocate

alias vi=nvim
alias vim=nvim

alias python=python3
alias pip='python3 -m pip'

# Alias for managing configuration files.
alias config='git --git-dir="$HOME/.cfg/" --work-tree="$HOME"'

PS1='[\u \W]\$ '
