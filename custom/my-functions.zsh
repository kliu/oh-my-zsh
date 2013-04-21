
alias d1="export JPDA=123"
alias d0="export JPDA="
alias f="open -a Finder ./"
alias fname="find . -name"
alias grep="grep -R --color=auto -i -H -n"
alias ip="curl icanhazip.com"
alias ls="ls -GlFh"
alias lt='echo "------Newest--" && ls -At1 -GlFh && echo "------Oldest--"'
alias ltr='echo "------Oldest--" && ls -Art1 -GlFh && echo "------Newest--"'
alias mkdir='mkdir -p -v'
alias mvn-debug="export MAVEN_OPTS='-Xdebug -Xrunjdwp:transport=dt_socket,address=8000,suspend=y,server=y'"
alias mvn-debugoff="export MAVEN_OPTS="
alias o="open -a"
alias pc="pwd | pbcopy"
alias sz="du -sh"
alias ungit="find . -name '.git' -exec rm -rf {} \;"

e () {
  [[ -a "$1" ]] || touch $1
  open -b com.sublimetext.2 "$@"
  #"/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" "$@"
}

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

console () {
  if [[ $# > 0 ]]; then
    query=$(echo "$*"|tr -s ' ' '|')
    tail -f /var/log/system.log|grep -i --color=auto -E "$query"
  else
    tail -f /var/log/system.log
  fi
}

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

# instant web server for current dir
function serve() {
  python -m SimpleHTTPServer ${1:-8080}
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

# exports a clean copy of the current git repo to a zip file
# `zipup ~/Desktop/gitarchive.zip`
function zipup() {
  git archive --format zip --output $1 master
}

safekey () {
  chmod 700 ~/.ssh
  chmod 600 ~/.ssh/*
  chmod 400 ~/.ssh/*.pem
}