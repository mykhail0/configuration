#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Add colors.
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip -color=auto'

# Misc
alias cal='cal --monday'
alias locate=plocate

# Ask before overwriting files.
alias mv='mv -i'
alias cp='cp -i'

alias vi=nvim
alias vim=nvim

# Python aliases.
alias python=python3
alias pip='python3 -m pip'

# Popular command, ergonomic alias.
alias ..='cd ..'
alias ...='cd ../..'
alias g='git'

# Configuration files management.
alias config='git --git-dir="$HOME/.cfg/" --work-tree="$HOME"'

PS1='[\u \W]\$ '
