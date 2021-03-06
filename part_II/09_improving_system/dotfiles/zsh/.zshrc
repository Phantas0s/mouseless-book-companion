fpath=($ZDOTDIR/external $fpath)

source "$XDG_CONFIG_HOME/zsh/aliases"

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

autoload -Uz compinit; compinit
_comp_options+=(globdots) # With hidden files
source ~/dotfiles/zsh/external/completion.zsh

autoload -Uz prompt_purification_setup; prompt_purification_setup

# Push the current directory visited on to the stack.
setopt AUTO_PUSHD
# Do not store duplicate directories in the stack
setopt PUSHD_IGNORE_DUPS
# Do not print the directory stack after using
setopt PUSHD_SILENT

bindkey -v
export KEYTIMEOUT=1

autoload -Uz cursor_mode && cursor_mode

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

source ~/dotfiles/zsh/external/bd.zsh

if [ $(command -v "fzf") ]; then
    source /usr/share/fzf/completion.zsh
    source /usr/share/fzf/key-bindings.zsh
fi

if [ "$(tty)" = "/dev/tty1" ];
then
    pgrep i3 || exec startx "$XDG_CONFIG_HOME/X11/.xinitrc"
fi

source $DOTFILES/zsh/scripts.sh

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
