# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh

if [[ ! -f ~/.zsh_plugins.zsh || ~/.zsh_plugins.txt -nt ~/.zsh_plugins.zsh ]]; then
  antidote bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.zsh
fi
source ~/.zsh_plugins.zsh

################################################################################
# When autosuggesting commands don't return really long ones
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

################################################################################
autoload zmv                                # zsh extension with mv that understands zsh patterns

################################################################################
# History and prompt management helpers
setopt EXTENDED_HISTORY                     # pre-req for timestamps in history
setopt HIST_IGNORE_ALL_DUPS                 # remove duplicate entries from history (1:1 match)
setopt PROMPT_SUBST                         # enable substitution in the commands, makes prompt more dynamic
setopt SHARE_HISTORY                        # share history between zsh instances
setopt PROMPTPERCENT                        # handles % specially for expansion - http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Prompt-Expansion
setopt NUMERIC_GLOB_SORT                    # use actual numeric instead of string sorting
setopt EXTENDED_GLOB                        # additional globbing support for * patterns
setopt interactivecomments                  # allow comments in the interactive shell
setopt histignorespace                      # do not store a command if prepended with space, useful for one off commands not for history

HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "

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
# FZF integration
if (( $+commands[fzf] )); then
  source <(fzf --zsh)
  export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border=rounded --info=inline"

  if (( $+commands[fd] )); then
    export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  fi
fi

################################################################################
# Advanced Completion System
# 1 Enable menu selection
# 2 Group completions by type (commands, files, etc)
# 3 Add descriptive headers to groups
# 4 Use LS_COLORS for file completions in the menu
# 5 Case-insensitive and smart matching (can type 'doc' to match 'Documents')
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

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
alias history='history -i'

################################################################################
# Remap vim to nvim
alias vim='nvim'

################################################################################
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
