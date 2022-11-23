function func() { ###
  print -z $( cli sh -f "/Users/$(whoami)/.dotfiles/oh-my-zsh/custom/my-functions.zsh" | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g' )
}

# Funny =================================
function busy() {
  cat /dev/urandom | hexdump -C | grep 'ca fe'
}

# System  =================================
alias f="open -a Finder ./"
alias o="open -a"
alias mkdir='mkdir -p -v'
alias grep="grep --color=auto -i -H -n"
alias ls="ls -GlFh"
alias lst='echo "------Newest--" && ls -At1 -GlFh && echo "------Oldest--"'
alias lstr='echo "------Oldest--" && ls -Art1 -GlFh && echo "------Newest--"'
alias br="br -sd"
alias bs="br --conf ~/.dotfiles/broot/select.toml"

# Utils =================================
function e() { ###
  [[ -a "$1" ]] || touch $1
  cot "$@"
}

function ef() {
  IFS=$'\n' files=($(fd . $1 --type f --exclude ".git" | fzf --multi -i --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-code} "${files[@]}"
}

function eb() {
  code $(bs)
}

function cf() {
  IFS=$'\n' files=($(fd . $1 --type f --exclude ".git" | fzf --multi -i --exit-0))
  [[ -n "$files" ]] && cot "${files[@]}"
}

function cb() {
  cot $(bs)
}

function man_pdf() {
  man -t "$1"|open -f -a "Preview.app"
}

function man_txt() {
  MANWIDTH=160 MANPAGER='col -bx' man $@ | code -
}

function hist() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

function cli() { ###
  java -jar ~/.m2/repository/me/helloworld/cli/1.0-SNAPSHOT/cli-1.0-SNAPSHOT-jar-with-dependencies.jar "$@"
}
source ~/.dotfiles/script/cli_completion

# Files & Dirs ===================================
function file_path() {
  pwd | pbcopy
}

function file_size() {
  du -sh "$@"
}

function file_extract () { #unarchive various compression formats based on extension
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

function file_extracts() {
  for f in *.tar.gz; do 
    d=`basename "$f" .tar.gz`
    mkdir "$d"
    (cd "$d" && tar xf "../$f")
  done
}

function cd() {
    if [[ "$#" != 0 ]]; then
        builtin cd "$@";
        return
    fi
    while true; do
        local lsd=$(echo ".." && \ls -p | \grep '/$' | sed 's;/$;;')
        local dir="$(printf '%s\n' "${lsd[@]}" |
            fzf --ansi -i --reverse --preview '
                __cd_nxt="$(echo {})";
                __cd_path="$(echo $(pwd)/${__cd_nxt} | sed "s;//;/;")";
                echo $__cd_path;
                echo;
                ls -p --color=always "${__cd_path}";
        ')"
        [[ ${#dir} != 0 ]] || return 0
        builtin cd "$dir" &> /dev/null
    done
}

function cdf() {
  dir=($(fd . $1 --type d --exclude ".git" | fzf -i --exit-0))
  [[ -n "$dir" ]] && cd "$dir"
}

function tree() { 
  br -c :pt "$@" 
}

function md5check() { 
  md5sum "$1" | grep "$2";
}

# Maven  =================================
function mvn_debug() { ###
  export MAVEN_OPTS='-Xdebug -Xrunjdwp:transport=dt_socket,address=8000,suspend=y,server=y'
}

function mvn_debugoff() { ###
  export MAVEN_OPTS=
}

# Git =================================
function git_ungit() {
  find . -name '.git' -exec rm -rf {} \;
}

function git_config_cisco() { ###
  git -c user.name="zhiyuliu" -c user.email="zhiyuliu@cisco.com"
}

function git_zip() {
  git archive --format zip --output $1 master
}

function git_branch_delete() {
  git branch -D $1
  git push origin :$1
}

alias glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy'"

function git_commit_search() {
  git log -S $1
}

function git_commit_diff() {
  git difftool $1^! 
}

function git_commit_show() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index \
      --header "enter to view, alt-y to copy hash" \
      --bind=ctrl-s:toggle-sort \
      --bind "alt-y:execute:$_gitLogLineToHash | pbcopy" \
      --bind "enter:execute:$_viewGitLogLine   | less -R" \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

function git_commit_show_preview() {
    glNoGraph |
        fzf --no-sort --reverse --tiebreak=index --no-multi \
            --ansi --preview="$_viewGitLogLine" \
                --header "enter to view, alt-y to copy hash" \
                --bind "enter:execute:$_viewGitLogLine   | less -R" \
                --bind "alt-y:execute:$_gitLogLineToHash | pbcopy"
}

function git_stash_show() {
  local out q k sha
  while out=$(
    git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
    fzf --ansi --no-sort --query="$q" --print-query \
        --expect=ctrl-d,ctrl-b);
  do
    mapfile -t out <<< "$out"
    q="${out[0]}"
    k="${out[1]}"
    sha="${out[-1]}"
    sha="${sha%% *}"
    [[ -z "$sha" ]] && continue
    if [[ "$k" == 'ctrl-d' ]]; then
      git diff $sha
    elif [[ "$k" == 'ctrl-b' ]]; then
      git stash branch "stash-$sha" $sha
      break;
    else
      git stash show -p $sha
    fi
  done
}

# Security =================================
function key_pub() {
  cat ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'
}

function key_safe() {
  chmod 700 ~/.ssh
  chmod 600 ~/.ssh/*
  chmod 400 ~/.ssh/*.pem
}

# Networking =================================
alias scp="scp -v -p -r -C"
# alias skype2='sudo /Applications/Skype.app/Contents/MacOS/Skype'
alias skype2='open -na /Applications/Skype.app --args --secondary --datapath="/Users/$(whoami)/Library/Application\ Support/Skype2"'

function list_port() {
  lsof -P -i -n
}

function list_ip() {
  curl ifconfig.me
}

function download() {
  if ! pgrep -x "aria2c" > /dev/null
  then
    aria2c --conf-path="/Users/$(whoami)/.dotfiles/aria2/aria2.conf" -D
  fi
  open "/Users/$(whoami)/.dotfiles/aria2/webui-aria2/docs/index.html"
}

function web_get() {
  curl -O "$@"
}

function web_get_site() {
  wget --random-wait -r -p -e robots=off -U mozilla "$@"
}

function web_serve() {
  # python3 -m http.server
  caddy file-server --browse
}

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

# Blog  =================================
function blog_draft() {
  POST=$(hexo new draft $1 | tail -n1 | sed 's/INFO  Created: //g')
  e $POST
}

function blog_pub() {
  POST=$(hexo publish $1 | tail -n1 | sed 's/INFO  Created: //g')
  e $POST
}

function blog_new() {
  POST=$(hexo new post $1 | tail -n1 | sed 's/INFO  Created: //g')
  e $POST
}

function hexo_preview() {
  open http://127.0.0.1:4000  
  hexo server
}

function hexo_deploy() {
  cd $BLOG_HOME
  hexo clean
  hexo generate -d
  cd -
}

# Kotlin  =================================
function kr() {
  echo Compiling, please wait...
  kotlinc $1 -include-runtime -d $TMPDIR\me.helloworld.kotlinr-out.jar
  echo Compiled. ---------------
  echo "\n"
  java -jar $TMPDIR\me.helloworld.kotlinr-out.jar
}

function ks() {
  kotlinc -script $1
}