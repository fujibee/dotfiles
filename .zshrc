autoload -U compinit
compinit

alias ls='ls -G'
alias ll='ls -lG'
alias la='ls -laG'
alias p='pwd'
alias j='jobs'
alias r='rails'

export LANG=ja_JP.UTF-8
export PATH=/usr/local/mysql/bin:/opt/local/bin:$PATH

#case ${UID} in
#0)
#    PROMPT="%B%{[31m%}%/#%{[m%}%b "
#    PROMPT2="%B%{[31m%}%_#%{[m%}%b "
#    SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
#    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
#        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
#    ;;
#*)
#    PROMPT="%F{red}`$HOME/.rvm/bin/rvm-prompt` %n@%m$%f "
#    PROMPT2="%{[32m%}%_%%%{[m%} "
#    SPROMPT="%{[32m%}%r is correct? [n,y,a,e]:%{[m%} "
#    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
#        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
#    ;;
#esac
#RPROMPT="%{[31m%}[%/]%{[m%}"

precmd () {
  PROMPT="%F{green}%n@%~%% %f"
  RPROMPT="%F{green}%F{red}[`$HOME/.rvm/bin/rvm-prompt`]%f"
}

# for history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history

# for rvm
if [[ -s /Users/fujibee/.rvm/scripts/rvm ]] ; then source /Users/fujibee/.rvm/scripts/rvm ; fi
