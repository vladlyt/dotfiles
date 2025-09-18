alias k="kubectl"


alias ls='lsd'
alias la='ls -la'
alias lt='ls --tree'

alias less="less -R"

alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"

alias dp='ssh $USER.devpod-nld; tc $DEFAULT_COLOR'
alias dpenvoy='ssh ltv-envoy-devpod.devpod-nld; tc $DEFAULT_COLOR'
alias dpquick='ssh ltv-quick-changes.devpod-nld; tc $DEFAULT_COLOR'

alias oc='object-config-client'

alias minimal='export STARSHIP_CONFIG="$HOME/.config/starship-minimal.toml"'
alias normal='export STARSHIP_CONFIG="$HOME/.config/starship-$CURRENT_MACHINE.toml"'

alias adh="arc diff"
alias adh="arc diff HEAD^"
alias ac="arc cascade -hc"
alias af="arc flow"

alias k8s-seed-ops='bazel run //src/code.uber.internal/infra/compute/scripts/k8s-seed-ops:k8s-seed-ops --'
alias mesh-gateway-ops='bazel run //src/code.uber.internal/swn/forward/bin/meshproxy-manager/scripts/ops:mesh-gateway-ops --'

typeset -A git_aliases
git_aliases=(
    s   "status"
    co  "checkout"
    br  "branch"
    ci  "commit"
    cm  "commit -m"
    a  "add ."
    cam  "commit --amend"
    caam  "commit -a --amend --no-edit"
    lg  "log --oneline --graph --decorate --all"
    df  "diff"
    dc  "diff --cached"
    mg  "merge"
    rb  "rebase"
    pl  "pull"
    psh "push"
    fa  "fetch --all --prune"
)

# Doing it as different environments might have different configurations for git
# and I don't wanna override ~/.gitconfig
# it might slow down startup time a bit, but whatever
for alias in "${(@k)git_aliases}"; do
    git config --global alias."$alias" "${git_aliases[$alias]}"
done
