compinit

# Press tab twice to get suggestions
zstyle ':completion:*' menu select

# Command line options completions for aliases
setopt COMPLETE_ALIASES

# If zsh fails to find a command, try to cd there instead
setopt autocd

# Allow completions when using sudo
# WARNING: completion scripts will run with sudo privileges
# zstyle ':completion::complete:*' gain-privileges 1
