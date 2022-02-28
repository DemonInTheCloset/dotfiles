compinit

# Press tab twice to get suggestions
zstyle ':completion:*' menu select

# Completion style               file ext.   complete  correct spelling mistakes
zstyle ':completion:*' completer _extensions _complete _approximate

# Try case insensitive or partial words after failing match
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Use caching
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

# Use ls Colors
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Command line options completions for aliases
setopt COMPLETE_ALIASES

# If zsh fails to find a command, try to cd there instead
setopt autocd

# Allow completions when using sudo
# WARNING: completion scripts will run with sudo privileges
# zstyle ':completion::complete:*' gain-privileges 1
