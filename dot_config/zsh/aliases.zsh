# Get places information
source "$ZDOTDIR"/places.zsh

# cd aliases
alias cdc="cd $CONFIG"
alias cdn="cd $CONFIG"/nvim
alias cdp="cd $PROGRAMMING"
alias cdu="cd $UNIVERSITY"
alias cdz="cd $ZDOTDIR"

alias cdlb="cd $HOME"/.local/bin
alias cdpass="cd $PASSWORD_STORE_DIR"

alias cdpc="cd $PROGRAMMING"/C
alias cdpcpp="cd $PROGRAMMING"/Cpp
alias cdpd="cd $PROGRAMMING"/D
alias cdphs="cd $PROGRAMMING"/Haskell
alias cdppy="cd $PROGRAMMING"/Python
alias cdprs="cd $PROGRAMMING"/Rust

alias cdchezmoi="cd $XDG_DATA_HOME"/chezmoi

# git aliases
alias gmsg-hook='ln -sv '"$CONFIG"'/git/hooks/commit-msg.sample `git rev-parse --git-dir`/hooks/commit-msg'

# grep aliases
alias grep='grep --color=auto'

# ip aliases
alias ip='ip --color=auto'

# ls aliases
alias la='ls -la --color=auto'
alias ls='ls --color=auto'

# nvim aliases
alias nvimconfig="$VISUAL $CONFIG"/nvim/init.lua

# Python aliases
alias mkvenv='virtualenv .venv'
alias sourcevenv='source .venv/bin/activate'

# ssh aliases
alias sshpi=ssh "$ALARMUSER@$ALARMPI"

# Yay aliases
alias yu='yay -Syu'
alias yy='yay -Syyu'
alias ys='yay -Ss'
alias yS='yay -S'

# zsh aliases
alias zshconfig="$VISUAL $ZDOTDIR"/config.zsh
alias sourcezshrc="source $ZDOTDIR"/.zshrc
