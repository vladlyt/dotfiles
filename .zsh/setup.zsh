zstyle ':completion:*' menu yes select
zstyle ':completion::complete:*' use-cache 1        # enables completion caching
zstyle ':completion::complete:*' cache-path ~/.zsh/cache
zstyle ':completion:*' users root $USER             # fix lag in google3
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
autoload -U compinit && compinit -u

# To know the key binding for a key, run `od -c` and press the key
bindkey '^[[3~'   delete-char         # enables DEL key proper behaviour
bindkey '^[[1;5C' forward-word        # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word       # [Ctrl-LeftArrow] - move backward one word
bindkey  "^[[H"   beginning-of-line   # [Home] - goes at the begining of the line
bindkey  "^[[F"   end-of-line         # [End] - goes at the end of the line

# Enables history saving
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt share_history        # share history between multiple instances of zsh

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
