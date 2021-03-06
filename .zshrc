HISTSIZE=10000
if (( ! EUID )); then
  HISTFILE=~/.history_root
else
  HISTFILE=~/.history
fi
SAVEHIST=10000

export ZSH="/Users/queueball/.oh-my-zsh"
ZSH_THEME="agnoster"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20    # do not recommend (the right arrow completion) long historical entries

plugins=(
  docker
  sudo
  timer
  zsh-autosuggestions  # extra
)

source $ZSH/oh-my-zsh.sh              # load the omz context

autoload zmv                          # zsh extension with mv that understands zsh patterns

setopt HIST_IGNORE_ALL_DUPS           # don't put the same command into history if it's a repeat
setopt PROMPT_SUBST                   # enable substitution in the commands
setopt SHARE_HISTORY                  # share history between zsh instances
setopt PROMPTPERCENT                  # handles % specially for expansion - http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Prompt-Expansion
setopt NUMERIC_GLOB_SORT              # use actual numeric instead of string sorting
setopt EXTENDED_GLOB                  # additional globbing support for * patterns
setopt interactivecomments            # allow comments in the interactive shell
setopt histignorespace                # do not store a command if prepended with space

export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/usr/local/bin:$PATH"    # fixes for homebrew
export PATH="/usr/local/sbin:$PATH"   # fixes for homebrew
export PATH="$PATH:$HOME/.tech/bash"  # put my custom bash scripts in the path
export PATH="$PATH:$HOME/.bin"        # put my custom bin folder in the path
export EDITOR="/usr/local/bin/vim"    # I like vim...
export VISUAL="/usr/local/bin/vim"    # I like vim...
export FIND_PARAMS=(-not -path '*/\.git*' -not -path '*/__pycache__*' -not -path '*/\.pytest_cache*')
export PYTHONDONTWRITEBYTECODE="IGNORE"

zstyle ':completion:*' menu select    # shows menu and highlights completion options

# Allows using $EDITOR to modify a commandline entry
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

if [[ -a $(which transmission-remote) ]]; then
  alias tra='transmission-remote'
  alias trar='transmission-remote -t all -r'
  alias traa='transmission-remote -a'
  alias tral='transmission-remote -l'
fi
alias reload='source ~/.zshrc'        # makes testing zshrc changes easier

eval "$(direnv hook zsh)"             # remember to run 'direnv allow' per directory it is used
