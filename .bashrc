#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source additional configurations.
# git specific
bash_git_cfg="$XDG_CONFIG_HOME/bash/git"
[[ -r "$bash_git_cfg" ]] && . "$bash_git_cfg"
# completions
completion="$XDG_CONFIG_HOME/bash/completion"
# TODO a bug with have (grub?)
[[ -r "$completion" ]] && . "$completion"

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
alias firefox='firefox-developer-edition'

# Configuration files management.
alias config='git --git-dir="$HOME/.cfg/" --work-tree="$HOME"'

PS1='\u@\h \W${PS1_CMD} $? \$ '
