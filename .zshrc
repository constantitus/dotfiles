export EDITOR='nvim'
export HISTFILE=~/.cache/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
export VISUAL='nvim'
export QT_STYLE_OVERRIDE=adwaita-dark

export MINGW32_PREFIX="/usr/bin/i686-w64-mingw32-gcc"
export MINGW64_PREFIX="/usr/bin/x86_64-w64-mingw32-gcc"

# Adding ~/bin and ~/cargo/bin to path
PATH=$PATH$( find $HOME/bin/ -type d -printf ":%p" ):$PATH
export PATH="$HOME/.cargo/bin:$HOME/.dotnet/tools:$HOME/Android/Sdk/cmdline-tools/latest/bin:$HOME/git/emsdk:$HOME/git/emsdk/upstream/emscripten:$HOME/git/emsdk/node/14.18.2_64bit/bin:$PATH"
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export WINEPREFIX=$HOME/.wine
export GODOT4_BIN=$HOME/bin/godot4

# Enable colors and change prompt:
autoload -U colors && colors
# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}＠%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
source ~/.config/zsh/kolo.zsh-theme

# Basic auto/tab complete (scrambled shit from other pepole's)
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
    lfu --last-dir-path="$tmp" "$@"
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

## NNN
#export NNN_OPTS="H" # 'H' shows the hidden files. Same as option -H (so 'nnn -deH')
## export LC_COLLATE="C" # hidden files on top
#export NNN_FIFO=/tmp/nnn.fifo # temporary buffer for the previews
#export NNN_PLUG='o:fzopen;e:-!sudo -E nvim $nnn*;h:-!hx $nnn*;p:preview-tui;x:!chmod +x $nnn;m:!mpv $nnn'
#
#NNN_TMPFILE='/tmp/.lastd'
#BLK="04" CHR="04" DIR="04" EXE="00" REG="00" HARDLINK="00" SYMLINK="06" MISSING="00" ORPHAN="01" FIFO="0F" SOCK="0F" OTHER="02"
#export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"

# # export SPLIT='v' # to split Kitty vertically

# source /usr/share/zsh/site-functions/zsh-autosuggestions.zsh
source ~/.config/zsh/icons.zsh
# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh 2>/dev/null
