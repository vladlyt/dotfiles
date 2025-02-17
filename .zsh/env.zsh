typeset -U path
path=(
    $path[@]
)


# to fix locales in perl
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export FZF_DEFAULT_OPTS='--height 20% --border' # decorates fzf search window with a border, and make the search box 20% high
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export HOMEBREW_NO_ENV_HINTS=1



if [[ -f ~/.machine ]]; then
    export CURRENT_MACHINE=$(<~/.machine)
else
    export CURRENT_MACHINE="local"
fi

# TODO can we install it on the devpod so it would open locally somehow
if [ "$CURRENT_MACHINE" = "local" ]; then
    export EDITOR="zed --wait"
else
    export EDITOR="vim"
fi
