HISTSIZE=10000
if (( ! EUID )); then
	HISTFILE=~/.history_root
else
	HISTFILE=~/.history
fi
SAVEHIST=10000

export ZSH="/Users/queueball/.oh-my-zsh"
# ZSH_THEME="gnzh"
ZSH_THEME="agnoster"

plugins=(
  git
  docker
  encode64
  python
  sudo
  vi-mode
)

source $ZSH/oh-my-zsh.sh

autoload zmv

setopt HIST_IGNORE_DUPS
setopt PROMPT_SUBST
setopt SHARE_HISTORY
setopt PROMPTPERCENT
setopt NUMERIC_GLOB_SORT
setopt EXTENDED_GLOB
setopt interactivecomments

export PATH="/usr/local/bin:$PATH"
export PATH="$PATH:$HOME/.tech/bash"
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
alias transr='transmission-remote -t all -r'
alias transa='transmission-remote -a'
alias transl='transmission-remote -l'
alias reload='source ~/.zshrc'
