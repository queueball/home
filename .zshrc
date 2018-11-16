HISTSIZE=10000
if (( ! EUID )); then
	HISTFILE=~/.history_root
else
	HISTFILE=~/.history
fi
SAVEHIST=10000

#alias ls="ls --color=auto"

export CLICOLOR=1;
# x default foreground or background
# Black        a    0;30    Dark Gray       A    1;30
# Blue         b    0;34    Light Blue      B    1;34
# Green        c    0;32    Light Green     C    1;32
# Cyan         d    0;36    Light Cyan      D    1;36
# Red          e    0;31    Light Red       E    1;31
# Purple       f    0;35    Light Purple    F    1;35
# Brown        g    0;33    Yellow          G    1;33
# Light Gray   h    0;37    White           H    1;37
#                1 2 3 4 5 6 7 8 9 0 1
export LSCOLORS='gxexxxxxbxxxxxxxxxxxec';
#export LSCOLORS=exfxcxdxbxegedabagacad;
autoload -Uz compinit
compinit
#  1 [ex] - (di) directories
#  2 [fx] - (ln) symbolic links
#  3 [cx] - (so) sockets
#  4 [dx] - (pi) pipes
#  5 [bx] - (ex) executable files
#  6 [eg] - (bd) block special
#  7 [ed] - (cd) character special
#  8 [ab] - () executable with setuid bit set
#  9 [ag] - () executable with setgid bit set
# 10 [ac] - () directory writable to others, with sticky bit
# 11 [ad] - () directory writable to others, without sticky bit
# fi File
# or Symbolic Link pointing to a non-existent file (orphan)
# mi Non-existent file pointed to by a symbolic link (visible when you type ls -l)
zstyle ':completion:*' list-colors 'di=0;36:ex=0;31:'
autoload zmv

setopt HIST_IGNORE_DUPS
setopt PROMPT_SUBST
setopt SHARE_HISTORY
setopt PROMPTPERCENT
#setopt AUTO_CD
setopt NUMERIC_GLOB_SORT
setopt EXTENDED_GLOB

# ┌─┐
# │ │
# └─┘
# http://www.tamasoft.co.jp/en/general-info/unicode.html

function get_column() {
	#(( LOCAL_COLUMNS= $COLUMNS - 3 ))
	(( LOCAL_COLUMNS= 21))
	repeat $LOCAL_COLUMNS printf "─";print
}

function set_yellow() { echo $'%{\e[38;5;011m%}' }
function set_white() { echo $'%{\e[38;5;015m%}' }
function set_red() { echo $'%{\e[38;5;009m%}' }
function set_green() { echo $'%{\e[38;5;010m%}' }
function set_cyan() { echo $'%{\e[38;5;014m%}' }
function set_end() { echo $'%{\e[0m%}' }

# Andale mono
# 10.10.x Menlo
#PROMPT=$'
#$(set_white)┌$(get_column)┐$(set_end)
#$(set_white)│ $(set_yellow)%n$(set_red)@$(set_white)%m$(set_green)%# $(set_cyan)%~$(set_end)
#$(set_white)└> $(set_end)'
PROMPT=$'$(set_white)┌ $(set_yellow)%n$(set_red)@$(set_white)%m$(set_green)%# $(set_cyan)%~ $(set_white)──>$(set_end)
$(set_white)└> $(set_end)'

export GOPATH=$HOME/.tech/gocode
export PATH=$PATH:$GOPATH/bin
export PATH="/usr/local/bin:$PATH"
export PATH="$PATH:$HOME/.bin"

tabs -2

export EDITOR="/usr/local/bin/vim"
export VISUAL="/usr/local/bin/vim"

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

alias mygdf='gdf -H --output=source,avail /dev/disk1s1'
alias ll='ls -alh'
alias trans='transmission-remote'
