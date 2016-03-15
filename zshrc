OS_TYPE='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   OS_TYPE='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
   OS_TYPE='osx'
fi
export OS_TYPE

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.dotfiles/oh-my-zsh

# Set name of the theme to load.
# Look in $ZSH
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

if [[ $OS_TYPE == 'osx' ]]; then
	ZSH_THEME="minimal-custom"
elif [[ $OS_TYPE == 'linux' ]]; then
	ZSH_THEME="minimal-hostname"
fi

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
if [[ $OS_TYPE == 'osx' ]]; then
	plugins=(ant brew bwana cp encode64 heroku git mvn osx sublime urltools safe-paste zsh-autosuggestions)
elif [[ $OS_TYPE == 'linux' ]]; then
	plugins=(ant cp encode64 git mvn urltools safe-paste)
fi

#export SOCKS_SERVER=127.0.0.1:1080

source $ZSH/oh-my-zsh.sh

# Encodeing
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Customize to your needs...
export PATH=$PATH:$HOME/.dotfiles/script

# Default Editor
if [[ $OS_TYPE == 'osx' ]]; then
	export EDITOR='subl -w' 	
fi

# Homebrew
export PATH=/usr/local/bin:$PATH

# JAVA
# wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u75-b13/jdk-7u75-linux-x64.tar.gz
if [[ $OS_TYPE == 'osx' ]]; then
	export JAVA_HOME=`/usr/libexec/java_home`
elif [[ $OS_TYPE == 'linux' ]]; then
	export JAVA_HOME=$HOME/Develop/java/jdk
	export PATH=$JAVA_HOME/bin:$PATH
fi

export CHECK_STYLE_HOME=$HOME/Develop/java/build/checkstyle-4.3
export COVERAGE_HOME=$HOME/Develop/java/build/cobertura-1.9
export JUNIT_HOME=/usr/share/junit
export ANT_HOME=/usr/share/ant
export GRADLE_HOME=$HOME/Develop/java/build/gradle
export MAVEN_HOME=$HOME/Develop/java/build/maven
export PATH=$PATH:$MAVEN_HOME/bin:$GRADLE_HOME/bin

# GO
#export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
export GOPATH=$HOME/Work/Go:$GOPATH

# Ruby
export PATH=$PATH:$HOME/.rvm/bin
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

# NodeJS
[[ -s "$HOME/.nvm/nvm.sh" ]] && . "$HOME/.nvm/nvm.sh" # Load NVM function

# Rust
export RUST_SRC_PATH=$HOME/Develop/rust/rust-nightly/src
export PATH=$PATH:$HOME/Develop/rust/racer/bin

# PYTHON
export PYTHON_ENV=$HOME/Develop/python/PyEnv
export PATH=$HOME/Develop/python/python3/bin:$PATH
export VIRTUALENV_DISTRIBUTE=true
export VIRTUAL_ENV_DISABLE_PROMPT=true
[[ -s "$PYTHON_ENV/bin/activate" ]] && source "$PYTHON_ENV/bin/activate"

# Heroku
### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Wireshark
if [[ $OS_TYPE == 'osx' ]]; then
	export WIRESHARK_APP_DIR=/Applications/Wireshark.app
	export PATH=$PATH:/opt/wireshark/bin
fi

# AWS
export AWS_AUTO_SCALING_HOME=$HOME/Develop/aws/AutoScaling
export AWS_AUTO_SCALING_URL=https://autoscaling.us-west-2.amazonaws.com
export AWS_CREDENTIAL_FILE=$HOME/Develop/aws/AutoScaling/credential-file-path
export PATH=$PATH:$AWS_AUTO_SCALING_HOME/bin
[[ -s "$PYTHON_ENV/bin/aws_zsh_completer.sh" ]] && source "$PYTHON_ENV/bin/aws_zsh_completer.sh"

# Google Cloud SDK
[[ -s "$HOME/Develop/tools/google-cloud-sdk/path.zsh.inc" ]] && source "$HOME/Develop/tools/google-cloud-sdk/path.zsh.inc"
[[ -s "$HOME/Develop/tools/google-cloud-sdk/completion.zsh.inc" ]] && source "$HOME/Develop/tools/google-cloud-sdk/completion.zsh.inc"

echo "=============== Quote Of The Day ==============="
echo
fortune
echo
echo "================================================"
echo