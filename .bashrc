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

# Set locale
export LC_ALL=en_US.UTF-8

# eval $(dircolors -b) # Set default LS_COLORS
# My LS_COLORS settings
eval $(dircolors -b | \
    sed -e 's/di=[^:]*:/di=01;94:/' \
        -e 's/or=[^:]*:/or=01;05;31:/' \
        -e 's/\*.m4v=01;35/&:\*.f4v=01;35/' \
)

BASH_EXTRA_CONF="$HOME/.bash.d"

_path_added() {
    local IFS=:
    local path="$1"
    local path_array
    set -f
    path_array=( $PATH )
    set +f
    for added in "${path_array[@]}"; do
        if [ "$added" = "$path" ]; then
            return 0
        fi
    done
    return 1
}

add_path() {
    local path="$1"
    local action="$2"
    if ! _path_added "$path"; then
        if [ "$action" = "prepend" ]; then
            export PATH="$path:$PATH"
        else
            export PATH="$PATH:$path"
        fi
    fi
}

for cfg_file in "$BASH_EXTRA_CONF"/*.env "$BASH_EXTRA_CONF"/*.rc "$BASH_EXTRA_CONF"/*.alias ; do
    if [ -s "$cfg_file" ]; then
        source "$cfg_file"
    fi
done
unset cfg_file

unset path_added _add_path

unset BASH_EXTRA_CONF
