autoload -U compinit
compinit

alias ls='ls -G'
alias ll='ls -lG'
alias la='ls -laG'
alias p='pwd'
alias j='jobs'

export LANG=ja_JP.UTF-8

case ${UID} in
0)
    PROMPT="%B%{[31m%}%/#%{[m%}%b "
    PROMPT2="%B%{[31m%}%_#%{[m%}%b "
    SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
*)
    PROMPT="%{[32m%}%n@%m%%%{[m%} "
    PROMPT2="%{[32m%}%_%%%{[m%} "
    SPROMPT="%{[32m%}%r is correct? [n,y,a,e]:%{[m%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
esac

RPROMPT="%{[31m%}[%/]%{[m%}"

# for history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history

# for rvm
if [[ -s /Users/fujikawa/.rvm/scripts/rvm ]] ; then source /Users/fujikawa/.rvm/scripts/rvm ; fi
