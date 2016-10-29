#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Disable PROMPT_COMMAND terminal title change method
# Use the PS1 variable or wmctrl
#PROMPT_COMMAND=":"

PS1='[\u@\h \W]\$ '

ulimit -s unlimited

# Aliases
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -la'
alias lA='ls -A'
alias lh='ls -lh'

alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

alias grep='grep --color'

BASH_EXTRA_CONF="$HOME/.bash.d"

for alias_file in "$BASH_EXTRA_CONF"/*.alias; do
    if [ -s "$alias_file" ]; then
        source "$alias_file"
    fi
    unset alias_file
done

unset BASH_EXTRA_CONF
