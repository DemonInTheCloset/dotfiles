# Get places information
source "$ZDOTDIR/places.zsh"

# cd aliases
alias cdc="cd $CONFIG"
alias cdn="cd $CONFIG/nvim"
alias cdp="cd $PROGRAMMING"
alias cdu="cd $UNIVERSITY"
alias cdz="cd $ZDOTDIR"

alias cdlb="cd $HOME/.local/bin"

alias cdpc="cd $PROGRAMMING/C"
alias cdpcpp="cd $PROGRAMMING/Cpp"
alias cdpd="cd $PROGRAMMING/D"
alias cdphs="cd $PROGRAMMING/Haskell"
alias cdppy="cd $PROGRAMMING/Python"
alias cdprs="cd $PROGRAMMING/Rust"

alias cdchezmoi="cd ~/.local/share/chezmoi"

# ls aliases
alias la='ls -la --color=auto'
alias ls='ls --color=auto'

# grep aliases
alias grep='grep --color=auto'

# ip aliases
alias ip='ip --color=auto'

# nvim aliases
alias nvimconfig="$VISUAL $CONFIG/nvim/init.lua"

# Python aliases
alias mkvenv="virtualenv .venv"
alias sourcevenv="source .venv/bin/activate"

# ssh aliases
alias sshpi="ssh $ALARMUSER@$ALARMPI"

# zsh aliases
alias zshconfig="$VISUAL $ZDOTDIR/config.zsh"
alias sourcezshrc="source $ZDOTDIR/.zshrc"