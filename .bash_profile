#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

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

for env_file in "$BASH_EXTRA_CONF"/*.env; do
    if [ -s "$env_file" ]; then
        source "$env_file"
    fi
    unset env_file
done

if [ -s "$BASH_EXTRA_CONF"/X.sh ]; then
    source "$BASH_EXTRA_CONF"/X.sh
fi

unset BASH_EXTRA_CONF
