#
# My ~/.zshrc
#

#Latest thing to get capslock work as ctrl
#
TERM=xterm-256color;
cdpath=(~ ~/work)

KEYTIMEOUT=0
WORDCHARS=${WORDCHARS//[&.;]}

keychain id_dsa
. ~/.keychain/vs-sh

case $TERM in
 linux)
 bindkey "^[[2~" yank
 bindkey "^[[3~" delete-char
 bindkey "^[[5~" up-line-or-history
 bindkey "^[[6~" down-line-or-history
 bindkey "^[[1~" beginning-of-line
 bindkey "^[[4~" end-of-line
 bindkey "^[e" expand-cmd-path ## C-e for expanding path of typed command
 bindkey "^[[A" up-line-or-search ## up arrow for back-history-search
 bindkey "^[[B" down-line-or-search ## down arrow for fwd-history-search
 bindkey " " magic-space ## do history expansion on space
 ;;
 *xterm*|rxvt|(dt|k|E)term)
 bindkey "^[[2~" yank
 bindkey "^[[3~" delete-char
 bindkey "^[[5~" up-line-or-history
 bindkey "^[[6~" down-line-or-history
 bindkey "^[[7~" beginning-of-line
 bindkey "^[[8~" end-of-line
 bindkey "^[e" expand-cmd-path ## C-e for expanding path of typed command
 bindkey "^[[A" up-line-or-search ## up arrow for back-history-search
 bindkey "^[[B" down-line-or-search ## down arrow for fwd-history-search
 bindkey " " magic-space ## do history expansion on space
 #

;;
esac
# Use hard limits, except for a smaller stack and no core dumps
unlimit
limit stack 8192
limit core 0
limit -s

umask 022

export LESS="-R"


alias rm='nocorrect rm -i'
alias rmf='nocorrect rm -f'
alias rmrf='nocorrect rm -fR'
alias mkdir='nocorrect mkdir'
alias my='mysql -u root '
alias grep=egrep
alias df='df -m'
alias less='less -M'
alias ispell='ispell -d russian'
alias ls="ls -AHFGa"
alias show="/usr/bin/feh "
alias light="xrdb read ~/.Xresources_light"
alias dark="xrdb read ~/.Xresources"
alias pdf="apvlv"

alias cc "./symfony cc"
alias replace='find -type f -iname "Root" -exec sed -i "s/192.168.1.1/192.168.1.2/g" {} \;'
alias cvsd='find -type d -iname "CVS" -exec rm -rf {} \;'
alias back='cd "$OLDPWD";pwd  '
alias vconf='sudo vim /etc/httpd/conf/extra/httpd-vhosts.conf'
alias vhost='sudo vim /etc/httpd/conf/extra/httpd-vhosts.conf'
alias vh='sudo vim /etc/httpd/conf/extra/httpd-vhosts.conf'
alias aconf='sudo vim /etc/httpd/conf/httpd.conf'
alias ms='sudo /etc/rc.d/mysqld start'
alias hosts='sudo vim /etc/hosts'
alias rooter='ssh vs@192.168.1.1'
alias gate='ssh vs@192.168.1.1'
alias router='ssh vs@router'
alias hrouter='ssh router@hrouter'
alias z='vim ~/.zshrc'
alias ll='ls -la'
alias messages='sudo tail -n 100 /var/log/messages.log'
alias log='sudo tail -n 100 /var/log/messages.log'
alias smb='sudo vim /etc/samba/smb.conf'
alias x='sudo vim /etc/X11/xorg.conf'
alias mconf='sudo vim /etc/mysql/my.cnf'
alias myconf='sudo vim /etc/mysql/my.cnf'
alias rc='sudo vim /etc/rc.conf'
alias edit='vim '
alias phpini='sudo vim /etc/php/php.ini'
alias hot='vim ~/.mc/hotlist'

# Shell functions
setenv() { typeset -x "${1}${1:+=}${(@)argv[2,$#]}" }

# csh compatibility
freload() { while (( $# )); do; unfunction $1; autoload -U $1; shift; done }

# Where to look for autoloaded function definitions

fpath=($fpath ~/.zfunc)

# Autoload all shell functions from all directories in $fpath (following
# symlinks) that have the executable bit on (the executable bit is not
# necessary, but gives you an easy way to stop the autoloading of a
# particular shell function). $fpath should not be empty for this to work.
for func in $^fpath/*(N-.x:t); autoload $func

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

## FreeBSD:
manpath="/usr/share/man:/usr/local/man:/usr/X11R6/man"

## Linux:
manpath="/usr/man:/usr/share/man:\
/usr/local/man:/usr/X11R6/man:/opt/qt/doc"


export MANPATH

hosts=($hosts ${${${(f)"$(</home/vs/.hostsrc)"}%%\ *}%%,*})

HISTFILE=~/.zhistory
SAVEHIST=5000
HISTSIZE=5000
## SAVEHIST Ð¸ HISTSIZE

DIRSTACKSIZE=20


setopt  APPEND_HISTORY
setopt  HIST_IGNORE_ALL_DUPS
setopt  HIST_IGNORE_SPACE
setopt  HIST_REDUCE_BLANKS

setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent noclobber
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash

setopt  No_Beep
setopt  IGNORE_EOF

# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile

# bindkey -v # vi -e emacs
#updated by baz
bindkey -v

bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand

autoload -U compinit
compinit

# Completion Styles
#
setopt AUTO_CD
zstyle ':completion:*:default' list-colors '${LS_COLORS}'
#zstyle ':completion:*:default' list-colors 'no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;3
#3;01:or=40;31;01:ex=01;31:'
#
# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions
# formacodeing and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''
# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
# command for process lists, the local web server details and host completion
zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
zstyle ':completion:*:urls' local 'www' '/home/vs/work' 'work'
zstyle '*' hosts $hosts

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-pacodeerns '*?.o' '*?.c~' \
'*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)
# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-pacodeerns '_*'
# baz
zstyle ':completion:*:*:*:*:hosts' list-colors '=*=30;41'
zstyle ':completion:*:*:*:*:users' list-colors '=*=$color[green]=$color[red]'

CFLAGS="-O3 -march=pentium4 -fomit-frame-pointer \
-funroll-loops -pipe -mfpmath=sse -mmmx -msse2 -fPIC"
CXXFLAGS="$CFLAGS"
BOOTSTRAPCFLAGS="$CFLAGS"
export CFLAGS CXXFLAGS BOOTSTRAPCFLAGS

export GREP_COLORS="mt=48;5;40;38;5;190"

function rip(){
	ssh baz@gate 'CVS_RSH=ssh cat /var/smb/server-info/ip.txt';
	return;
}

function mip(){
	ssh baz@gate 'CVS_RSH=ssh cat /var/smb/server-info/ip.txt';
	return;
}

function bas(){
if [ ! $1 ] ; then
    print "Error! Search in basket requires string argument! Example: bas mystring"
    return 1;
fi
print "Search for $1 in basket ..."
#here is a variant with colored egrep works fine.
#find /home/vs/.kde/share/apps/basket/baskets -type f -iname "*.html" -exec egrep ".$1." {} \;|html2text|egrep --color=always $1
find /home/vs/.kde4/share/apps/basket/baskets -type f -iname "*.html" -exec grep --color=always ".$1." {} \;|html2text
}


function mai(){
if [ ! $1 ] ; then
    print "Error! Search in mail requires string argument! Example: mai mystring"
    return 1;
fi
print "Search for $1 in .thunderbird/0k4skpcg.default/Mail ..."
find .thunderbird/0k4skpcg.default/Mail -type f -iname "*" -exec grep ".$1." {} \;|html2text|ack $1
}

VIM=/usr/bin/vim

VIMRUNTIME=~/.vim

EDITOR=$VIM
SVN_EDITOR=$VIM

export EDITOR=vim
#synclient TouchPadoff=1

alias xterm='xterm -geometry 800x600 -fa Liberation Mono -fs 11'

function title {
	  if [[ $TERM == "screen" ]]; then
		# Use these two for GNU Screen:
		print -nR $' 33k'$1$' 33'\
		print -nR $' 33]0;'$2$''
	  elif [[ $TERM == "xterm-256color" || $TERM == "rxvt" ]]; then
		# Use this one instead for XTerms:
		#print -Pn "\e]0;%n@%m: %~\a"
		#print -nR $' 33]0;'$*$''
		#print -Pn '\e]0;%n@%m: %~\a'
		echo -n "\033]0;${HOST}:$cwd\007"
		# set title to xterm
		#print -nR "\e]0;%n@%m: %~\a"
	  fi
}

function precmd { title zsh "$PWD" }

function preexec {
	emulate -L zsh
	local -a cmd; cmd=(${(z)1})
	title $cmd[1]:t "$cmd[2,-1]"
}

#edit()
#{
    ## the powerful select
    #PROMPT3="Choose File : "
    #select f in $(ls **/*.php |egrep -i "${param}[^/]*.php")
    #do
     #if [[ "$REPLY" = q ]]
     #then
        #break
     #elif [[ -n "$f" ]]; then
        #vim $f
     #fi
    #done
#}


 setopt No_X_Trace;
 setopt No_Verbose;

 if ! type redisplay 2>/dev/null 1>/dev/null; then
    declare -x PS1
    declare -x PS2;
    declare -x PS3;
    declare -x PS4;

    setopt Prompt_Percent
    setopt No_Prompt_CR

    PS2="%_>";
    PS3="?#";
    PS4="+i>";

    bindkey -v

    zmodload zsh/parameter &>/dev/null

    function redisplay()
    {
        builtin zle .redisplay
        ( true ; show_mode "INSERT") &!
    }
    zle -N redisplay

    function redisplay2()
    {
        builtin zle .redisplay
        (true ; show_mode "NORMAL") &!
    }
    zle -N redisplay2

    function screenclear ()
    {
        echo -n "\033[2J\033[400H"
        builtin zle .redisplay
        (true ; show_mode "INSERT") &!
    }
    #zle -N screenclear

    function screenclearx ()
    {
        repeat 2 print
        local MYLINE="$LBUFFER$RBUFFER"
        highlight $MYLINE
        repeat 4 print
        builtin zle redisplay
    }
    zle -N screenclearx

    function show_mode()
    {
        #local COL
        #local x
        #COL=COLUMNS-3
        #COL=COL-$#1
        #x=$(echo $PREBUFFER | wc -l )
        #x=x+1
        #echo -n "7[$x;A[0;G"
        #echo -n ""
        #echo -n "[0;37;44m--$1--[0m"
        #echo -n "8"
    }

    ###	  vi-add-eol (unbound) (A) (unbound)
    ###		 Move  to the end of the line and enter insert mode.

    function vi-add-eol()
    {
        show_mode "INSERT"
        builtin zle .vi-add-eol
    }
    zle -N vi-add-eol

    ###	  vi-add-next (unbound) (a) (unbound)
    ###		 Enter insert mode after the  current  cursor  posiÂ­
    ###		 tion, without changing lines.

    function vi-add-next()
    {
        show_mode "INSERT"
        builtin zle .vi-add-next
        # OLDLBUFFER=$LBUFFER
        # OLDRBUFFER=$RBUFFER
        # NNUMERIC=$NUMERIC
        # bindkey -M viins "" vi-cmd-mode-a
    }
    zle -N vi-add-next

    ###	  vi-change (unbound) (c) (unbound)
    ###		 Read a movement command from the keyboard, and kill
    ###		 from  the  cursor  position  to the endpoint of the
    ###		 movement.  Then enter insert mode.  If the  command
    ###		 is vi-change, change the current line.

    function vi-change()
    {
        show_mode "INSERT"
        builtin zle .vi-change
    }
    zle -N vi-change

    ###	  vi-change-eol (unbound) (C) (unbound)
    ###		 Kill  to the end of the line and enter insert mode.

    function vi-change-eol()
    {
        show_mode "INSERT"
        builtin zle .vi-change-eol
    }
    zle -N vi-change-eol

    ###	  vi-change-whole-line (unbound) (S) (unbound)
    ###		 Kill the current line and enter insert mode.

    function vi-change-whole-line()
    {
        show_mode "INSERT"
        builtin zle .vi-change-whole-line
    }
    zle -N vi-change-whole-line

    ###	  vi-insert (unbound) (i) (unbound)
    ###		 Enter insert mode.

    function vi-insert()
    {
        show_mode "INSERT"
        builtin zle .vi-insert
    }
    zle -N vi-insert

    ###	  vi-insert-bol (unbound) (I) (unbound)
    ###		 Move to the first non-blank character on  the	line
    ###		 and enter insert mode.

    function vi-insert-bol()
    {
        show_mode "INSERT"
        builtin zle .vi-insert-bol
    }
    zle -N vi-insert-bol

    ###	  vi-open-line-above (unbound) (O) (unbound)
    ###		 Open a line above the cursor and enter insert mode.

    function vi-open-line-above()
    {
        show_mode "INSERT"
        builtin zle .vi-open-line-above
    }
    zle -N vi-open-line-above

    ###	  vi-open-line-below (unbound) (o) (unbound)
    ###		 Open a line below the cursor and enter insert mode.

    function function vi-open-line-below()
    {
        show_mode "INSERT"
        builtin zle .vi-open-line-below
    }
    zle -N vi-open-line-below

    ###	  vi-substitute (unbound) (s) (unbound)
    ###		 Substitute the next character(s).

    function vi-substitute()
    {
        show_mode "INSERT"
        builtin zle .vi-substitute
    }
    zle -N vi-substitute

    ###	  vi-replace (unbound) (R) (unbound)
    ###		 Enter overwrite mode.

    function vi-replace()
    {
        show_mode "REPLACE"
        builtin zle .vi-replace
    }
    zle -N vi-replace

    ###	  vi-cmd-mode (^X^V) (unbound) (^[)
    ###		 Enter	command  mode;	that  is, select the `vicmd`
    ###		 keymap.  Yes, this is bound  by  default  in  emacs
    ###		 mode.

    function vi-cmd-mode()
    {
        show_mode "NORMAL"
        builtin zle .vi-cmd-mode
    }
    zle -N vi-cmd-mode

    ###	  vi-oper-swap-case
    ###		 Read a movement command from the keyboard, and swap
    ###		 the case of all characters from the cursor position
    ###		 to the endpoint of the movement.  If  the  movement
    ###		 command  is vi-oper-swap-case, swap the case of all
    ###		 characters on the current line.
    ###

    bindkey -M vicmd "A"	vi-add-eol
    bindkey -M vicmd "C"	vi-change-eol
    bindkey -M vicmd "I"	vi-insert-bol
    bindkey -M vicmd "O"	vi-open-line-above
    bindkey -M vicmd "R"	vi-replace
    bindkey -M vicmd "S"	vi-change-whole-line
    bindkey -M vicmd "\eO2R"	vi-rev-repeat-search
    bindkey -M vicmd "\eOA"     up-line-or-history
    bindkey -M vicmd "\eOB"     down-line-or-history
    bindkey -M vicmd "\eOC"     vi-forward-char
    bindkey -M vicmd "\eOD"     vi-backward-char
    bindkey -M vicmd "\eOP"	run-help
    bindkey -M vicmd "\eOR"	vi-repeat-search
    bindkey -M vicmd "\e[1~"    vi-first-non-blank
    bindkey -M vicmd "\e[2~"    vi-insert
    bindkey -M vicmd "\e[3~"    vi-delete-char
    bindkey -M vicmd "\e[4~"    vi-end-of-line
    bindkey -M vicmd "\e[5~"    history-search-backward
    bindkey -M vicmd "\e[6~"    history-search-forward
    bindkey -M vicmd "\e[A"     up-line-or-history
    bindkey -M vicmd "\e[B"     down-line-or-history
    bindkey -M vicmd "\e[C"     vi-forward-char
    bindkey -M vicmd "\e[D"     vi-backward-char
    bindkey -M vicmd "\e[F"     vi-end-of-line
    bindkey -M vicmd "\e[H"     vi-first-non-blank
    bindkey -M vicmd "^?"	backward-delete-char
    bindkey -M vicmd "^A"	beginning-of-line
    bindkey -M vicmd "^B"	history-search-backward
    bindkey -M vicmd "^E"	end-of-line
    bindkey -M vicmd "^F"	history-search-forward
    bindkey -M vicmd "^H"	backward-delete-char
    bindkey -M vicmd "^R"	redo
    bindkey -M vicmd "^X^R"     redisplay2
    bindkey -M vicmd "a"	vi-add-next
    bindkey -M vicmd "c"	vi-change
    bindkey -M vicmd "ga"	what-cursor-position
    bindkey -M vicmd "g~"	vi-oper-swap-case
    bindkey -M vicmd "i"	vi-insert
	bindkey -M vicmd "o"	vi-open-line-below
    bindkey -M vicmd "s"	vi-substitute
    bindkey -M vicmd "u"	undo
    #bindkey -M vicmd "^A"	beginning-of-line
    #bindkey -M vicmd "^E"	end-of-line
    #bindkey -M vicmd "Ã¨"    beginning-of-line
    #bindkey -M vicmd "Ã¬"   end-of-line
	bindkey -M vicmd "è" beginning-of-line
	bindkey -M vicmd "ì" end-of-line
	#Last  modification
	#bindkey -M vicmd "^H"   backward-kill-word

    bindkey -M viins "\eO2R"	vi-rev-repeat-search
    bindkey -M viins "\eOA"     up-line-or-history
    bindkey -M viins "\eOB"     down-line-or-history
    bindkey -M viins "\eOC"     vi-forward-char
    bindkey -M viins "\eOD"     vi-backward-char
    bindkey -M viins "\eOP"	run-help
    bindkey -M viins "\eOR"	vi-repeat-search
    bindkey -M viins "\e[1~"	vi-first-non-blank
    bindkey -M viins "\e[2~"    vi-insert
    bindkey -M viins "\e[3~"    vi-delete-char
    bindkey -M viins "\e[4~"    vi-end-of-line
    bindkey -M viins "\e[5~"    history-search-backward
    bindkey -M viins "\e[6~"    history-search-forward
    bindkey -M viins "\e[A"     up-line-or-history
    bindkey -M viins "\e[B"     down-line-or-history
    bindkey -M viins "\e[C"     vi-forward-char
    bindkey -M viins "\e[D"     vi-backward-char
    bindkey -M viins "\e[F"     vi-end-of-line
    bindkey -M viins "\e[H"     vi-first-non-blank
    bindkey -M viins "^?"	backward-delete-char
	bindkey -M viins "^A"	beginning-of-line
	bindkey -M viins "^E"	end-of-line
    bindkey -M viins "^X^R"	redisplay
    bindkey -M viins "^Xl"	screenclearx
    bindkey -M viins "^p"	copy-prev-word

fi;

 if test "$(whence -w la)" != "la: function" ; then
    if test -e ~/.profile.d/DIR_COLORS; then
        eval "$(dircolors -b ~/.profile.d/DIR_COLORS)"
    fi;

    if test -e /etc/profile.d/DIR_COLORS; then
        eval "$(dircolors -b /etc/profile.d/DIR_COLORS)"
    fi;

    if test "$(whence -w la)" = "la: alias"; then
        unalias la
    fi;

    if test "$(whence -w ls)" = "ls: alias"; then
        unalias ls
    fi;

    if test -z "${LS_OPTIONS}"; then
        declare -x LS_OPTIONS="--literal --color=tty --tabsize=0";
    fi;

    alias ls="$(which ls) ${LS_OPTIONS}"

    declare -x -f -u la;
    declare -x -f -u dir;
    declare -x -f -u d;
 fi;



#insert mode by default
#bindkey -A myviins main
bindkey "è" beginning-of-line
bindkey "ì" end-of-line
print ''
typeset -Ag abbreviations
abbreviations=(
  "ar"   "sudo apachectl restart"
  "cip" 'find -type f -iname "Root" -exec sed -i "s/192.168.1.1/192.168.1.2/g" {} \;'
  "co"   "cvs -d:ext:vs@192.168.1.1:/var/lib/cvs checkout "
  "cu"   "cvs -q update -dP"
  "com"   'cvs commit -m "'
  "cc"   'cvs commit -m "'
  "delcvs" 'find -type d -iname "CVS" -exec rm -rf {} \;'
  "delsvn" 'find -type d -iname ".svn" -exec rm -rf {} \;'
  "res" 'svn resolve --accept working yourconflictdir'
  "sr" 'svn resolve --accept working yourconflictdir'
  "dsvn" 'find -type d -iname ".svn" -exec rm -rf {} \;'
  "ds" 'find -type d -iname ".svn" -exec rm -rf {} \;'
  "de" 'sudo dhclient eth0'
  "dw" 'sudo dhclient wlan0'
  "hotlist" "gvim ~/.mc/hotlist"
  'ig' 'svn propedit svn:ignore cache'
  'ignore' 'svn propedit svn:ignore cache'
  "ff" 'for x in *mpg; do ffmpeg -i "$x" -deinterlace -ar 44100 -r 25 -qmin 3 -qmax 6 "${x/.mpg/.flv}";done'
  "find"  'find . -iname "*" | xargs grep -l "what?" 2>/dev/null'
  "k" "sudo kill -9 "
  "lftp"  "open mirror --verbose --delete --use-cache --parallel=2 --no-perms --no-umask -X '*.tpl.php' -X 'config.php' --reverse httpdocs httpdocs"
  "log" "cd /var/log/"
  "lg" 'ls -la | grep '
  "ll" 'ls -AHFGa | grep '
  'l' "php symfony i18n:extract frontend ru --auto-save"
  'mod' 'php symfony doctrine:generate-module --with-show --non-verbose-templates frontend news RudcomNews'
  'module' 'php symfony doctrine:generate-module --with-show --non-verbose-templates frontend news RudcomNews'
  'plugin' 'php symfony doctrine:generate-module --with-show --non-verbose-templates frontend news RudcomNews'
  'plug' 'php symfony plugin:install '
  'lang' "php symfony i18n:extract frontend ru --auto-save"
  'rmf' 'find . -type f -name "*.po" -not -name "*en_GB\.po" | xargs rm'
  "sp" 'for i in *.pdf;do gs -sDEVICE=pdfwrite  -q -dNOPAUSE -dBATCH  -sOutputFile=sample-"$i".pdf  -dFirstPage="$i"  -dLastPage="$i" filename;done'
  "replace" 'for f in *flag_*;do mv "$f" "${f/flag_/}";done;'
  "md" "mysqldump --default-character-set=utf8 -u root  database > ~/database.sql"
  "hot" "gvim ~/.mc/hotlist"
  "p" "sudo ps aux | grep "
  "pa" "sudo ps aux | grep "
  "ps" "sudo pacman -Ss "
  "pu" "sudo pacman -Syu "
  "pi" "sudo pacman -S "
  "yu" "sudo yaourt -Syu "
  "yi" "yaourt -S "
  "ys" "yaourt -Ss "
  "yr" "yaourt -R "
  "remove" 'find -type d -iname "CVS" -exec rm -rf {} \;'
  "resize"  'mogrify -resize 2480x3508 -path ./big -monitor ./*.jpg'
  "rs"  'mogrify -resize 2480x3508\! -path ./big -monitor ./*.jpg'
  "replace" 'find -type f -iname "Root" -exec sed -i "s/192.168.1.1/192.168.1.2/g" {} \;'
  "r" 'find -type f -iname "Root" -exec sed -i "s/192.168.1.1/192.168.1.2/g" {} \;'
  "s"  "show "
  "sau"  "sudo aptitude update"
  "sas"  "sudo aptitude search"
  "sai"  "sudo aptitude install"
  "sco" "svn checkout svn+ssh://vs@192.168.1.1/var/lib/svn/projectname/trunk projectname"
  "svi" 'svn import -m "Initial commit" svn+ssh://vs@192.168.1.1/var/lib/svn/projectname/trunk projectname'
  "sui"  "sudo aptitude install"
  "sadu" "sudo aptitude dist-upgrade"
  "sdu"  "sudo aptitude dist-upgrade"
  'sd'   'svn diff --diff-cmd=meld '
  "su"   "svn update"
  "sur"  "sudo aptitude remove"
  "sc"   'svn commit -m "'
  "scc"   './symfony cc'
  "smb" 'sudo mount -t cifs -o smbguest //192.168.1.1/exchange /home/vs/remote/exchange@gate'
  "st"   'svn status'
  "ss"   'svn status | grep php'
  "t"    'sudo tail -n 100 /var/log/'
  "conf" "sudo vim /etc/apache2/sites-enabled/hosts.conf"
  "ssar" "sudo service apache2 restart"
  "sa"   "sudo apachectl start"
  "sar" "sudo service apache2 restart"
  "son" "synclient touchPadOff=1"
  "sof" "synclient touchPadOff=0"
  "scp" "scp backup.sql.bz2 user@server:/tmp/backup.sql.bz2"
  "wmii"  "vim ~/.wmii-3.5/events.py"
  "wmi"    "vim ~/.wmii-3.5/events.py"
  'con' 'convert -quality 100 -font /path_to_font/arial.ttf -pointsize 40 /path_to_image/test.jpg -gravity "South" -draw "text -110,0 Alexander Kerzhakov" /tmp/res.jpg'
)


magic-abbrev-expand() {
	local MATCH
	LBUFFER=${LBUFFER%%(#m)[_a-zA-Z0-9]#}
	LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
	zle self-insert
}

no-magic-abbrev-expand() {
  LBUFFER+=' '
}

zle -N magic-abbrev-expand
zle -N no-magic-abbrev-expand
bindkey "ó" magic-abbrev-expand
bindkey "^x " no-magic-abbrev-expand
# My attempt
bindkey "^R" history-incremental-search-backward
#backspace removes word
#bindkey "\Eu" vi-backward-kill-char
bindkey "è" beginning-of-line
bindkey "ì" end-of-line
# backspace
#bindkey "" vi-backward-kill-word
bindkey "÷" vi-backward-kill-word
bindkey "^H" backward-delete-char

export CVS_RSH=ssh

autoload -U promptinit
promptinit
#prompt bigfade
#prompt suse
#prompt bart
prompt adam1

#export PAGER=most #/usr/bin/man $@
export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
    gvim -vR -c 'set ft=man nonumber nomod nolist' -c 'map q :q<CR>' \
    -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
    -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""

WMII_IS_RUNNING=`ps a | grep wmii | awk '/[^"grep"] wmii$/'`
if [ -n "$WMII_IS_RUNNING" ]; then
  PROMPT_COMMAND='dirs | wmiir write /client/sel/label'
fi
