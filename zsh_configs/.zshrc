################################################################################
# Disk space is cheap, so load up on a ton of history
HISTSIZE=100000
if (( ! EUID )); then
  HISTFILE=~/.history_root
else
  HISTFILE=~/.history
fi
SAVEHIST=100000

################################################################################
# Load oh-my-zsh
export ZSH="/Users/queueball/.oh-my-zsh"

################################################################################
# Make it colorful
ZSH_THEME="agnoster"

################################################################################
# When autosuggesting commands don't return really long ones
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

################################################################################
# load plugins that defined more complex behavior
plugins=(
  sudo                                      # <esc><esc> to toggle the last command with sudo in front
  timer                                     # automatically times a command and reports it on the right side of the terminal
  zsh-autosuggestions                       # suggest commands as you type
)

source $ZSH/oh-my-zsh.sh                    # load the omz context

autoload zmv                                # zsh extension with mv that understands zsh patterns

################################################################################
# History and prompt management helpers
setopt HIST_IGNORE_ALL_DUPS                 # remove duplicate entries from history (1:1 match)
setopt PROMPT_SUBST                         # enable substitution in the commands, makes prompt more dynamic
setopt SHARE_HISTORY                        # share history between zsh instances
setopt PROMPTPERCENT                        # handles % specially for expansion - http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Prompt-Expansion
setopt NUMERIC_GLOB_SORT                    # use actual numeric instead of string sorting
setopt EXTENDED_GLOB                        # additional globbing support for * patterns
setopt interactivecomments                  # allow comments in the interactive shell
setopt histignorespace                      # do not store a command if prepended with space, useful for one off commands not for history

################################################################################
# Homebrew path fix
eval "$(/opt/homebrew/bin/brew shellenv)"

################################################################################
# Custom paths for my custom scripts, want bash to override python in the event
# of an overlap
export PATH="$PATH:$HOME/.tech/bash"
export PATH="$PATH:$HOME/.bin"

################################################################################
# Switch to nvim for the shells EDITOR and VISUAL instead of (nano?)
export EDITOR="/opt/homebrew/bin/nvim"
export VISUAL="/opt/homebrew/bin/nvim"

################################################################################
# environmental quality of life improvments
export PYTHONDONTWRITEBYTECODE="IGNORE"     # turns off creating pyc files
export _PIP_LOCATIONS_NO_WARN_ON_MISMATCH=1 # suppress pip warnings while switching to sysconfig
export DOCKER_SCAN_SUGGEST=false            # remove synk advertising
export HOMEBREW_NO_ENV_HINTS=1              # remove homebrew hints

################################################################################
# On double <tab> show a table of the possible completions and then press
# <enter> to select an option
zstyle ':completion:*' menu select

################################################################################
# Allows using $EDITOR to modify a commandline entry with <c-x><c-e>
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

################################################################################
# Shortcuts for using the transmission client since transmission-remote is long
# This is shared in non home contexts so only make the link work if the command
# is available
if [[ -a $(which transmission-remote) ]]; then
  alias tra='transmission-remote'
  alias trar='transmission-remote -t all -r'
  alias traa='transmission-remote -a'
  alias tral='transmission-remote -l'
fi

################################################################################
# Reset the zsh to make it easier to test changes to the zshrc
alias reload='exec zsh -l'

################################################################################
# Shortcut for a common find command
alias qf='find . -iname'

################################################################################
# Remap vim to nvim
alias vim='nvim'

# source /Users/queueball/.docker/init-zsh.sh || true # Added by Docker Desktop
