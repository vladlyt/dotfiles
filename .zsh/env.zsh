typeset -U path
path=(
    $path[@]
)

path+=~/.local/bin

# to fix locales in perl
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export FZF_DEFAULT_OPTS='--height 20% --border' # decorates fzf search window with a border, and make the search box 20% high
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export HOMEBREW_NO_ENV_HINTS=1

# Claude setup
export ANTHROPIC_VERTEX_PROJECT_ID="progsys-genai-198685";
export CLAUDE_CODE_USE_VERTEX=1;
export CLOUD_ML_REGION="us-east5";

if [[ -f ~/.machine ]]; then
    export CURRENT_MACHINE=$(<~/.machine)
else
    export CURRENT_MACHINE="local"
fi

if [[ -f ~/.machine-type ]]; then
    export USER_MACHINE_PREFIX="$(<~/.machine-type)"
fi

# TODO can we install it on the devpod so it would open locally somehow
# if [ "$CURRENT_MACHINE" = "local" ]; then
    # export EDITOR="zed --wait"
# else
    # export EDITOR="vim"
# fi

export EDITOR="vim"