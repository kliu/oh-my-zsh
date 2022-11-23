
export TERM="xterm-256color"
source $HOME/.local_env

# Homebrew
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/opt/gnu-getopt/bin:$PATH

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.dotfiles/oh-my-zsh

# Set name of the theme to load.
# Look in $ZSH
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

# ZSH_THEME="bullet-train"

# Theme
# BULLETTRAIN_EXEC_TIME_ELAPSED=0
# BULLETTRAIN_TIME_BG=red
# BULLETTRAIN_TIME_FG=white
# BULLETTRAIN_GIT_BG=cyan
# BULLETTRAIN_PROMPT_ORDER=(
#   time
#   status
#   dir
#   virtualenv
#   git
#   cmd_exec_time
# )

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"
# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"
# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13
# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"
# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"
# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"
# Which plugins would you like to load? (plugins can be found in $ZSH/plugins/*)
# Custom plugins may be added to $ZSH/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(ant autojump brew command-not-found cp encode64 git mvn macos urltools rsync safe-paste zsh-autosuggestions zsh-syntax-highlighting zsh-completions)
source $ZSH/oh-my-zsh.sh

# Encodeing
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# History
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP

# Customize to your needs...
export PATH=$HOME/.dotfiles/script:$PATH

# Default Editor
export EDITOR='cot'

# PSQL & Postgres
# export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

# JAVA
export JAVA_HOME=$HOME/.sdkman/candidates/java/current
export JDK_HOME=$HOME/.sdkman/candidates/java/current
export PATH=$JAVA_HOME/bin:$PATH

# Ruby
export PATH=$PATH:$HOME/.rvm/bin
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

# NodeJS
[[ -s "$HOME/.nvm/nvm.sh" ]] && . "$HOME/.nvm/nvm.sh" # Load NVM function
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  fi
}
add-zsh-hook chpwd load-nvmrc

# Rust
export RUSTUP_HOME=$HOME/.rustup
export CARGO_HOME=$HOME/.cargo
source $HOME/.cargo/env

# Android
export PATH=$HOME/Library/Android/sdk/platform-tools:$PATH

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Elasticsearch
export ES_HOME="$HOME/Work/BBSC/sandbox/elasticsearch-7.14.0"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH=$HOME/.app/git-fuzzy/bin/:$PATH

# Broot
source $HOME/.config/broot/launcher/bash/br

# less
if [[ -x /usr/local/bin/lesspipe.sh ]]; then
    export LESSOPEN="|/usr/local/bin/lesspipe.sh %s"
    export LESS_ADVANCED_PREPROCESSOR=1
fi

autoload -U compinit && compinit

# Starship
## brew install startship
export STARSHIP_CONFIG=$HOME/.dotfiles/starship/starship.toml
eval "$(starship init zsh)"

echo
echo "=============== Poem Of The Tab ==============="
echo
fortune -e songci-fortunes
echo
echo "================================================"
echo
