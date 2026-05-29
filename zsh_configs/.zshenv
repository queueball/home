################################################################################
# Ensure the path contains only unique entries
typeset -U path

################################################################################
# Tool precendence
#   uv -> everything else -> my bash scripts
# 
# Note that uv will contain my custom python scripts too on top of normal
# uv bins
################################################################################

################################################################################
# Sanity
################################################################################

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
