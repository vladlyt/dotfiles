alias k="kubectl"


alias ls='lsd'
alias la='ls -la'
alias lt='ls --tree'

alias less="less -R"

alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"

alias dp='ssh $USER.devpod-nld; tc $DEFAULT_COLOR'

alias minimal='export STARSHIP_CONFIG="$HOME/.config/starship-minimal.toml"'
alias normal='export STARSHIP_CONFIG="$HOME/.config/starship-$CURRENT_MACHINE.toml"'

alias ad="arc diff HEAD^"