
# Funny =================================
alias busy="cat /dev/urandom | hexdump -C | grep 'ca fe'"

# Develop =================================
alias d1="export JPDA=123"
alias d0="export JPDA="
alias mvn-debug="export MAVEN_OPTS='-Xdebug -Xrunjdwp:transport=dt_socket,address=8000,suspend=y,server=y'"
alias mvn-debugoff="export MAVEN_OPTS="
alias ungit="find . -name '.git' -exec rm -rf {} \;"
alias gitc='git -c user.name="zhiyuliu" -c user.email="zhiyuliu@cisco.com"'

e () {
  [[ -a "$1" ]] || touch $1
  code "$@"
  # subl "$@"
  #"/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" "$@"
}

function zipup() {
  git archive --format zip --output $1 master
}

function gits() {
  git $@ --config "http.proxy=socks5://$SOCKS_SERVER"
}

function setjdk() {
    export JAVA_HOME=`/usr/libexec/java_home -v $@`
}

alias lsjava='/usr/libexec/java_home -V 2>&1 | grep ", " | cut -d , -f 1 | cut -d : -f 3 | tr -d " "'

# Sync =================================

function push() {
    local POSITIONAL=()
    while [[ $# -gt 0 ]]
    do
    local key="$1"

    case $key in
        -d|--device)
        local DEVICE="$2"
        shift # past argument
        shift # past value
        ;;
        -m|--message)
        local MESSAGE="$2"
        shift # past argument
        shift # past value
        ;;
        -f|--file)
        local ATTACHMENT="$2"
        shift # past argument
        shift # past value
        ;;
        # --default)
        # DEFAULT=YES
        # shift # past argument
        # ;;
        *)    # unknown option
        POSITIONAL+=("$1") # save it in an array for later
        shift # past argument
        ;;
    esac
    done
    set -- "${POSITIONAL[@]}" # restore positional parameters

    command="curl -s --form-string \"token=${PUSHOVER_TOKEN}\" --form-string \"user=${PUSHOVER_USERKEY}\"  --form-string \"message=${MESSAGE}\""

    if [ -z ${DEVICE+x} ]; then 
        echo "Message will be pushed to all devices";
    else 
        command+=" --form-string \"device=${DEVICE}\"";
    fi

    if [ -z ${ATTACHMENT+x} ]; then 
        ; 
    else 
        command+=" -F \"attachment=@${ATTACHMENT}\"";
    fi

    command+=" https://api.pushover.net/1/messages.json"
  
    eval $command
}

# System  =================================
alias f="open -a Finder ./"
alias o="open -a"
alias fname="find . -name"
alias grep="grep --color=auto -i -H -n"
alias mkdir='mkdir -p -v'
alias pc="pwd | pbcopy"
alias sz="du -sh"
if [[ $OS_TYPE == 'osx' ]]; then
	alias ls="ls -GlFh"
	alias lt='echo "------Newest--" && ls -At1 -GlFh && echo "------Oldest--"'
	alias ltr='echo "------Oldest--" && ls -Art1 -GlFh && echo "------Newest--"'
elif [[ $OS_TYPE == 'linux' ]]; then
	alias ls="ls -lFh --color=auto"
	alias lt='echo "------Newest--" && ls -At1 -lFh --color=auto && echo "------Oldest--"'
	alias ltr='echo "------Oldest--" && ls -Art1 -lFh --color=auto && echo "------Newest--"'
fi

console () {
  if [[ $# > 0 ]]; then
    query=$(echo "$*"|tr -s ' ' '|')
    tail -f /var/log/system.log|grep -i --color=auto -E "$query"
  else
    tail -f /var/log/system.log
  fi
}

fk () {
  IFS=$'\n'
  PS3='Kill which process? (1 to cancel): '
  select OPT in "Cancel" $(fp $1); do
    if [ $OPT != "Cancel" ]; then
      kill $(echo $OPT|awk '{print $NF}')
    fi
    break
  done
  unset IFS
}

manpdf () { #display man page as a PostScript PDF in Preview.app
  man -t "$1"|open -f -a "Preview.app"
}

mantxt () { #open man page in TextMate
  MANWIDTH=160 MANPAGER='col -bx' man $@ | e
}

function sr {
    find . -type f -exec sed -i '' s/$1/$2/g {} +
}

# File =================================
extract () { #unarchive various compression formats based on extension
        if [ -f $1 ] ; then
                case $1 in
                        *.tar.bz2)          tar xjf $1       ;;
                        *.tar.gz)           tar xzf $1       ;;
                        *.bz2)              bunzip2 $1       ;;
                        *.rar)              rar x $1         ;;
                        *.gz)               gunzip $1        ;;
                        *.tar)              tar xf $1        ;;
                        *.tbz2)             tar xjf $1       ;;
                        *.tgz)              tar xzf $1       ;;
                        *.zip)              unzip $1         ;;
                        *.Z)                uncompress $1    ;;
                        *.dmg)              hdiutil mount $1 ;;
                        *)                  echo "'$1' cannot be extracted via extract()" ;;
                esac
        else
                echo "'$1' is not a valid file"
        fi
}

md5check() { md5sum "$1" | grep "$2";}

# Security =================================
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

safekey () {
  chmod 700 ~/.ssh
  chmod 600 ~/.ssh/*
  chmod 400 ~/.ssh/*.pem
}

# Networking =================================
alias websiteget="wget --random-wait -r -p -e robots=off -U mozilla"
alias listen="lsof -P -i -n"
alias ip="curl icanhazip.com"
alias scp="scp -v -p -r -C"
alias curls='curl --socks5-hostname $SOCKS_SERVER'
alias cget='curl -O'
alias cgets='curls -O'
alias sshs="ssh -o 'ProxyCommand=nc -X 5 -x 127.0.0.1:1080 %h %p' -o 'ServerAliveInterval=10'"
alias proxy='proxychains4'
alias aria='aria2c -c -x16 -s20 -j20'

rrestore() {
  if [[ $# == 2 ]]; then
    rsync -avz --progress -e ssh $1:$2 .
  else
    echo "Usage: rbak host path"
  fi
}

rbackup() {
  if [[ $# == 2 ]]; then
    rsync -avz --progress -e ssh . $1:$2
  else
    echo "Usage: rbak host path"
  fi
}

function serve() {
  python3 -m http.server
}

call () {
  number=`echo "$1"`
  if [[ "$number" =~ ^'#' ]]; then
    number=`echo "${number:1}"`
    if [[ "$number" =~ ^'+' ]]; then
      number=`echo "$number"`
    else
      number=`echo "+86${number}"`
    fi
  fi
  # number=`echo $1|sed 's/[\(\)\+ \-]//g'|sed 's/^1//'|sed 's/^/+/'`
  osascript -e "tell application \"Skype\" to send command \"CALL $number\" script name \"CLIDIALER\""
}

jekyll_deploy() {
  jekyll build
  if [ -d ".git" ] ; then
    git add --all .
    git commit -m "Update site"
    git push origin source
    cd _site
    git add --all .
    git commit -m "Update site"
    git push origin master
    cd ..
  else
    rsync -rlptDvz --delete --progress --exclude '_site' . root@helloworld.me:/mnt/data/develop/kliu.helloworld.me
    rsync -rlptDvz --delete --progress _site/  root@helloworld.me:/mnt/data/docs
  fi
}

jekyll_newpost() {
  touch _posts/$1.md
  mkdir downloads/$1
}

hexo_draft() {
  cd $BLOG_HOME
  POST=$(hexo new draft $1 | tail -n1 | sed 's/INFO  Created: //g')
  cd -
  subl $POST
}

hexo_pub() {
  cd $BLOG_HOME
  POST=$(hexo publish $1 | tail -n1 | sed 's/INFO  Created: //g')
  cd -
  subl $POST
}

hexo_new() {
  cd $BLOG_HOME
  POST=$(hexo new post $1 | tail -n1 | sed 's/INFO  Created: //g')
  cd -
  subl $POST
}

hexo_preview() {
  open http://127.0.0.1:4000  
  hexo --cwd $BLOG_HOME server
}

hexo_deploy() {
  cd $BLOG_HOME
  hexo clean
  hexo generate -d
  cd -
}

pfd() {
  osascript 2>/dev/null -e '
    tell application "Finder"
      return POSIX path of (target of window 1 as alias)
    end tell'
}

cdf() {
  cd "$(pfd)"
}

marked() {
  if [ $1 ]; then
    open -a "Marked" $1;
  else
    open -a "Marked";
  fi
}

function kotlinr() {
  echo Compiling, please wait...
  kotlinc $1 -include-runtime -d $TMPDIR\me.helloworld.kotlinr-out.jar
  echo Compiled. ---------------
  java -jar $TMPDIR\me.helloworld.kotlinr-out.jar
}