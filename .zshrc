ZSH_FOLDER=~/.zsh

source $ZSH_FOLDER/setup.zsh

# https://github.com/junegunn/fzf
fzf_version_output=$(fzf --version)
fzf_version=$(echo "$fzf_version_output" | grep -o '[0-9]*\.[0-9]*' | head -1)
if [[ $(echo "$fzf_version > 0.48" | bc) -eq 1 ]]; then
    source <(fzf --zsh)
else
    source ~/.fzf/shell/completion.zsh
    source ~/.fzf/shell/key-bindings.zsh
fi

# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
source $ZSH_FOLDER/zsh-autosuggestions/zsh-autosuggestions.zsh

# git clone https://github.com/Aloxaf/fzf-tab ~/.zsh/fzf-tab
source $ZSH_FOLDER/fzf-tab/fzf-tab.plugin.zsh

# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
source $ZSH_FOLDER/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# https://github.com/wting/autojump
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
[ -f /usr/share/autojump/autojump.sh ] && . /usr/share/autojump/autojump.sh

# # kubernetes autosuggest
if [ -f /usr/local/bin/kubectl ]; then source <(kubectl completion zsh); fi

# brew setup
[[ -s ~/.zprofile ]] && source ~/.zprofile

# cargo setup / other
[[ -s ~/.profile ]] && source ~/.profile

# Rust completions
# mkdir ~/.zfunc && rustup completions zsh > ~/.zfunc/_rustup && rustup completions zsh cargo > ~/.zfunc/_cargo
fpath+=~/.zfunc

source $ZSH_FOLDER/env.zsh
source $ZSH_FOLDER/setup.zsh
source $ZSH_FOLDER/functions.zsh
source $ZSH_FOLDER/python.zsh
source $ZSH_FOLDER/starship.zsh
source $ZSH_FOLDER/aliases.zsh

# setup colors of prompt
if [ "$CURRENT_MACHINE" = "prod" ]; then
    export DEFAULT_COLOR=#BF21CE
elif [ "$CURRENT_MACHINE" = "devpod" ]; then
    export DEFAULT_COLOR=#33D7FF
elif [ "$CURRENT_MACHINE" = "local" ]; then
    export DEFAULT_COLOR=#33FF35
else
    export DEFAULT_COLOR=#33FF35
fi


# Set different prompt based on environment
export STARSHIP_CONFIG="$HOME/.config/starship-$CURRENT_MACHINE.toml"

tc $DEFAULT_COLOR  # set iterm color

# https://github.com/starship/starship
eval "$(starship init zsh)"


if [ "$USER_MACHINE_PREFIX" = "envoy" ]; then
    export LLVM_CONFIG=/usr/local/llvm-my14/bin/llvm-config
fi