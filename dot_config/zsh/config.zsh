# Source Autoload Funtions
source "$ZDOTDIR/autoload.zsh"

# Source Completion settings
source "$ZDOTDIR/completion.zsh"

# Source Hooks
source "$ZDOTDIR/hooks.zsh"

# Source Personal Aliases
source "$ZDOTDIR/aliases.zsh"

# Source Interactive Shell Variables
# Color settings
typeset -U LESSOPEN
LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESSOPEN

typeset -U LESS
LESS=' -R '
export LESS

typeset -U LS_COLORS
eval $(dircolors)

# Set prompt
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# Remind me about aliases
source /usr/share/zsh/plugins/alias-tips/alias-tips.plugin.zsh
