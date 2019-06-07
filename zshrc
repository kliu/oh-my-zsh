OS_TYPE='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   OS_TYPE='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
   OS_TYPE='osx'
fi
export OS_TYPE
export TERM="xterm-256color"

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.dotfiles/oh-my-zsh

# Set name of the theme to load.
# Look in $ZSH
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

if [[ $OS_TYPE == 'osx' ]]; then
	ZSH_THEME="bullet-train"
elif [[ $OS_TYPE == 'linux' ]]; then
	ZSH_THEME="minimal-hostname"
fi

# Theme
BULLETTRAIN_EXEC_TIME_ELAPSED=0
BULLETTRAIN_TIME_BG=red
BULLETTRAIN_TIME_FG=white
BULLETTRAIN_GIT_BG=cyan
BULLETTRAIN_PROMPT_ORDER=(
	time
	status
	dir
    virtualenv
    git
    cmd_exec_time
)

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
plugins=(ant autojump brew bwana cp encode64 heroku git mvn osx sublime urltools rsync safe-paste zsh-autosuggestions zsh-syntax-highlighting history-substring-search zsh-completions)
#export SOCKS_SERVER=127.0.0.1:1080

source $ZSH/oh-my-zsh.sh

# Encodeing
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Customize to your needs...
export PATH=$HOME/.dotfiles/script:$PATH

# Default Editor
if [[ $OS_TYPE == 'osx' ]]; then
	export EDITOR='subl -w'
fi

# Homebrew
export PATH=/usr/local/bin:$PATH

# PSQL & Postgres
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

# JAVA
# wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u75-b13/jdk-7u75-linux-x64.tar.gz
if [[ $OS_TYPE == 'osx' ]]; then
	# export JAVA_HOME=`/usr/libexec/java_home`
    export JAVA_HOME=$HOME/.sdkman/candidates/java/current
elif [[ $OS_TYPE == 'linux' ]]; then
	export JAVA_HOME=$HOME/Develop/java/jdk
fi

export PATH=$JAVA_HOME/bin:$PATH

# GO
export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export GOBIN="${GOPATH}/bin"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin:${GOBIN}"
test -d "${GOPATH}" || mkdir "${GOPATH}"
test -d "${GOBIN}" || mkdir "${GOBIN}"
test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"

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
# export RUST_SRC_PATH=$HOME/Develop/rust/rust-nightly/src
# export PATH=$PATH:$HOME/Develop/rust/racer/bin

# PYTHON
# export PYTHON_ENV=$HOME/Develop/python/PyEnv
# export PATH=$HOME/Develop/python/python3/bin:$PATH
# export VIRTUALENV_DISTRIBUTE=true
# export VIRTUAL_ENV_DISABLE_PROMPT=true
# [[ -s "$PYTHON_ENV/bin/activate" ]] && source "$PYTHON_ENV/bin/activate"
# export PATH=/usr/local/opt/python/libexec/bin:$PATH

# Heroku
### Added by the Heroku Toolbelt
# export PATH="/usr/local/heroku/bin:$PATH"
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi
# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/zhiyuliu/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

# Wireshark
if [[ $OS_TYPE == 'osx' ]]; then
	export WIRESHARK_APP_DIR=/Applications/Wireshark.app
	export PATH=$PATH:/opt/wireshark/bin
fi

# AWS
# export AWS_AUTO_SCALING_HOME=$HOME/Develop/aws/AutoScaling
# export AWS_AUTO_SCALING_URL=https://autoscaling.us-west-2.amazonaws.com
# export AWS_CREDENTIAL_FILE=$HOME/Develop/aws/AutoScaling/credential-file-path
# export PATH=$PATH:$AWS_AUTO_SCALING_HOME/bin
# [[ -s "$PYTHON_ENV/bin/aws_zsh_completer.sh" ]] && source "$PYTHON_ENV/bin/aws_zsh_completer.sh"

# Google Cloud SDK
# [[ -s "$HOME/Develop/tools/google-cloud-sdk/path.zsh.inc" ]] && source "$HOME/Develop/tools/google-cloud-sdk/path.zsh.inc"
# [[ -s "$HOME/Develop/tools/google-cloud-sdk/completion.zsh.inc" ]] && source "$HOME/Develop/tools/google-cloud-sdk/completion.zsh.inc"

# Android
export PATH=$HOME/Library/Android/sdk/platform-tools:$PATH


# echo "=============== Quote Of The Day ==============="
# echo
# fortune
# echo
# echo "================================================"
# echo

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

#Local
source ~/.local_env

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

autoload -U compinit && compinit

echo
echo "=============== Poem Of The Day ==============="
echo
fortune -e songci-fortunes
echo
echo "================================================"
echo
