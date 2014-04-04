# Path to your oh-my-zsh configuration.
ZSH=$HOME/.dotfiles/oh-my-zsh

# Set name of the theme to load.
# Look in $ZSH
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="minimal"

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
plugins=(ant brew bwana cp encode64 heroku git mvn osx sublime urltools safe-paste)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$PATH:$HOME/.dotfiles/script

# Default Editor

export EDITOR='subl -w'

# Homebrew
export PATH=/usr/local/bin:$PATH

# JAVA
export JAVA_HOME=`/usr/libexec/java_home`
export CHECK_STYLE_HOME=$HOME/Develop/java/build/checkstyle-4.3
export COVERAGE_HOME=$HOME/Develop/java/build/cobertura-1.9
export JUNIT_HOME=/usr/share/junit
export ANT_HOME=/usr/share/ant
export GRADLE_HOME=$HOME/Develop/java/build/gradle

# GO
export GOROOT=$HOME/Develop/go
export GOBIN=$GOROOT/bin
export PATH=$PATH:$GOBIN:$GRADLE_HOME/bin

# Ruby
export PATH=$PATH:$HOME/.rvm/bin
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

# NodeJS
[[ -s "$HOME/.nvm/nvm.sh" ]] && . "$HOME/.nvm/nvm.sh" # Load NVM function

# PYTHON
export PYTHON_ENV=$HOME/Develop/python/PyEnv
export PATH=$HOME/Develop/python/python3/bin:$PATH
export VIRTUALENV_DISTRIBUTE=true
export VIRTUAL_ENV_DISABLE_PROMPT=true
source $PYTHON_ENV/bin/activate

# Heroku
export PATH="/usr/local/heroku/bin:$PATH"

# Wireshark
export WIRESHARK_APP_DIR=/Applications/Wireshark.app
export PATH=$PATH:/opt/wireshark/bin

# AWS
export AWS_AUTO_SCALING_HOME=$HOME/Develop/aws/AutoScaling
export AWS_AUTO_SCALING_URL=https://autoscaling.us-west-2.amazonaws.com
export AWS_CREDENTIAL_FILE=$HOME/Develop/aws/AutoScaling/credential-file-path
export PATH=$PATH:$AWS_AUTO_SCALING_HOME/bin
source $PYTHON_ENV/bin/aws_zsh_completer.sh




