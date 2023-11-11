# .zshrc themed without oh-my-zsh or any other bloated crap.
# The theme may or may not be stolen from oh-my-zsh.
# IMPORTANT: If you're running anything else besides Gentoo, modify
# the last line. Different package managers store the syntax highlighting
# files in different places. Have fun finding yours, lmao

#PATH=$PATH$( find $HOME/bin/ -type d -printf ":%p" ):$PATH
export PATH="\
$HOME/bin:\
$HOME/.cargo/bin:\
$HOME/.local/bin:\
$HOME/.dotnet/tools:\
$HOME/Android/Sdk/cmdline-tools/latest/bin:\
$HOME/yabridge:\
$HOME/.config/bspwm/bin:\
$PATH"

export MAKEOPTS="-j8"

# Enable colors:
autoload -U colors && colors

# Source prompt
# source ~/.config/zsh/kolo.zsh-theme
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Basic auto/tab complete (scrambled shit from other pepole's dotfiles)
autoload -Uz compinit
zmodload zsh/complist
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-.]=** r:|=**'
zstyle ':completion:*' max-errors 2 numeric
zstyle ':completion:*' menu select=5
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '$HOME/.zshrc'
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' rehash true
zstyle ':completion:*' use-compctl false
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
compinit
_comp_options+=(globdots)		# Include hidden files.

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lfu to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    $HOME/bin/lfu --last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

bindkey -s '^f' 'fg\n'
bindkey -s '^r' 'nvim\n'

bindkey '^[[1;5C' forward-word                    # ctrl + ->
bindkey '^[[1;5D' backward-word                   # ctrl + <-
bindkey ' ' magic-space

bindkey "^[[H" beginning-of-line # HOME
bindkey "^[[F" end-of-line # END
bindkey "^[[3~" delete-char # DEL

bindkey "^Z" undo # CTRL+Z
bindkey "^Y" redo # CTRL+Y

# zsh plugins
plugins=(zsh-syntax-highlighting z git zsh-autosuggestions dirhistory)


# History configurations
setopt autocd                 # auto cd
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data
setopt HIST_EXPIRE_DUPS_FIRST # sets duplicates in the histfile to disappear first


# configure `time` format
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

export MANPATH="/usr/local/man:$MANPATH"

# sorce your aliases
source ~/.alias
source ~/.env

# source /usr/share/zsh/site-functions/zsh-autosuggestions.zsh
source ~/.config/zsh/icons.zsh
# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh 2>/dev/null
