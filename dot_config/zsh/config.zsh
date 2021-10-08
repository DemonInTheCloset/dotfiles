# Source Autoload Funtions
source "$ZDOTDIR/autoload.zsh"

# Source Completion settings
source "$ZDOTDIR/completion.zsh"

# Source Hooks
source "$ZDOTDIR/hooks.zsh"

# Source Personal Aliases
source "$ZDOTDIR/aliases.zsh"

# Set prompt
prompt off
powerline-daemon -q
. /usr/share/powerline/bindings/zsh/powerline.zsh
