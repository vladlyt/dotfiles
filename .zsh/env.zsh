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