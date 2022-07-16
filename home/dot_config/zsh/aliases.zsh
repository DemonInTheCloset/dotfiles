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

alias cdchezmoi="cd $XDG_DATA_HOME"/chezmoi

# cd + fzy aliases
alias fcdc='cd "$(fd -I -d 1 -t d . "$CONFIG" | fzf)"'
alias fcdp='cd "$(fd -I -d 2 -t d . "$PROGRAMMING" | fzf)"'
alias fcdu='cd "$(fd -I -d 2 -t d . "$UNIVERSITY" | fzf)"'

# git aliases
alias gmsg-hook='ln -sv '"$CONFIG"'/git/hooks/commit-msg.sample `git rev-parse --git-dir`/hooks/commit-msg'
alias dategittag='git tag -a "v$(date -I)"'

# Github CLI aliases
alias gh-view-last='gh run list -L1 | sed -n '"'"'s/.*push\s\+\([0-9]\+\).*/\1/p'"'"' | xargs gh run view --log-failed | bat'

# grep aliases
alias grep='grep --color=auto'

# ip aliases
alias ip='ip --color=auto'

# ls aliases
alias la='ls -lah --color=auto'
alias ls='ls --color=auto'

# mbsync aliases
alias mbsync="mbsync -c $XDG_CONFIG_HOME/isync/mbsyncrc"
alias mbsynca="mbsync -c $XDG_CONFIG_HOME/isync/mbsyncrc -a"

# nvim aliases
alias ngit='nvim +:Neogit +:tabonly!'
alias note='nvim +:setlocal\ buftype=nofile +:setlocal\ bufhidden=hide +:setlocal\ noswapfile'
alias nview="nvim -R"
alias nvimconfig="$VISUAL $XDG_CONFIG_HOME"/nvim/init.lua
alias nvimupdate="nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'"

# neomutt aliases
alias nmsync='neomutt && mbsync -c '"$XDG_CONFIG_HOME"'/isync/mbsyncrc -a'

# newsboat aliases
alias nb='newsboat'
alias nbr='newsboat -r'

# paru aliases
alias paruS='paru -S'
alias paruSs='paru -Ss'
alias paruSi='paru -Si'
alias paruSyyu='paru -Syyu'
alias paruRns='paru -Rns'
alias paruQi='paru -Qi'
alias paruQl='paru -Ql'
alias paruQs='paru -Qs'

# Python aliases
alias mkvenv='virtualenv .venv'
alias sourcevenv='source .venv/bin/activate'

# ssh aliases
alias sshpi=ssh "$ALARMUSER@$ALARMPI"

# startx
alias startwm="startx $XDG_CONFIG_HOME/X11/xinitrc -- $XDG_CONFIG_HOME/X11/xserverrc vt$XDG_VTNR"

# zsh aliases
alias zshconfig="$VISUAL $ZDOTDIR"/config.zsh
alias sourcezshrc="source $ZDOTDIR"/.zshrc
