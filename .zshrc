#------------------------------------------------------------------#
# File:     .zshrc   ZSH resource file                             #
# Version:  0.1.16                                                 #
#------------------------------------------------------------------#

#------------------------------
# History stuff
#------------------------------
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

#------------------------------
# Variables
#------------------------------
export BROWSER="firefox"
export EDITOR="vim"
#export PAGER="vimpager"
export PATH="${HOME}/bin:${PATH}:/home/astrid/.local/bin"

#-----------------------------
# Dircolors
#-----------------------------
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS


#------------------------------
# Alias stuff
#------------------------------
alias ls="ls --color -F"
alias ll="ls --color -lh"
alias tmux="tmux -2"
alias x="killall tmux"
#------------------------------
# Alias Suffix
#------------------------------
alias -s pdf="zathura"
alias -s html="firefox"
alias -s jpeg="eog "
alias -s png="eog "
alias -s jpg="eog "
alias -s svg="inkscape "

#------------------------------
# ShellFuncs
#------------------------------
# -- coloured manuals
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

#------------------------------
# Comp stuff
#------------------------------
zmodload zsh/complist 
autoload -Uz compinit
compinit
zstyle :compinstall filename '${HOME}/.zshrc'

#- buggy
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
#-/buggy

zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*'   force-list always

#- complete pacman-color the same as pacman
compdef _pacman pacman-color=pacman

#------------------------------
# Window title
#------------------------------
case $TERM in
  termite|*xterm*|rxvt|rxvt-unicode|rxvt-256color|rxvt-unicode-256color|(dt|k|E)term)
    #~ precmd () {
      #~ vcs_info
      #~ print -Pn "\e]0;[%n@%M][%~]%#\a"
    #~ } 
    preexec () { print -Pn "\e]0;[%n@%M][%~]%# ($1)\a" }
    ;;
  screen|screen-256color)
    precmd () { 
      #~ vcs_info
      print -Pn "\e]83;title \"$1\"\a" 
      print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~]\a" 
    }
    preexec () { 
      print -Pn "\e]83;title \"$1\"\a" 
      print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~] ($1)\a" 
    }
    ;; 
esac

#------------------------------
# Prompt
#------------------------------
autoload -U colors zsh/terminfo
colors
setprompt() {

# load some modules
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats "%{${fg[cyan]}%}[%{${fg[red]}%}%s%{${fg[cyan]}%}][%{${fg[blue]}%}%r/%S%%{${fg[cyan]}%}][%{${fg[blue]}%}%b%{${fg[yellow]}%}%m%u%c%{${fg[cyan]}%}]%{$reset_color%}"
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

# make some aliases for the colours: (coud use normal escap.seq's too)
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
eval PR_$color='%{$fg[${(L)color}]%}'
done
PR_NO_COLOR="%{$terminfo[sgr0]%}"

# Check the UID
if [[ $UID -ge 1000 ]]; then # normal user
eval PR_USER='${PR_MAGENTA}Astrid${PR_NO_COLOR}'
#eval PR_USER='${PR_RED}Astrid${PR_NO_COLOR}'
eval PR_USER_OP='${PR_CYAN}%#${PR_NO_COLOR}'
#eval PR_USER_OP='${PR_BLACK}#${PR_NO_COLOR}'
elif [[ $UID -eq 0 ]]; then # root
eval PR_USER='${PR_RED}%n${PR_NO_COLOR}'
eval PR_USER_OP='${PR_WHITE}%#${PR_NO_COLOR}'
fi

# Check if we are on SSH or not
if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then 
eval PR_HOST='${PR_YELLOW}%M${PR_NO_COLOR}' #SSH
else 
eval PR_HOST='%M${PR_NO_COLOR}' # no SSH
fi
# set the prompt
PS1=$'${PR_CYAN}[${PR_MAGENTA}${PR_HOST}${PR_CYAN}][${PR_MAGENTA}%~${PR_CYAN}]${PR_USER_OP} '
#PS1=$'${PR_BLACK}[${PR_USER}${PR_BLACK}@${PR_HOST}${PR_BLACK}][${PR_BLACK}%~${PR_BLACK}]${PR_USER_OP} '
PS2=$'%_>'
RPROMPT=$'${vcs_info_msg_0_}'
}
setprompt
#neofetch --image /home/astrid/Images/term_kaori1.png --crop_mode normal --size 250 --image_size=auto --config off --prompt_height 5
neofetch --color_blocks off
#export RUST_SRC_PATH=/home/astrid/utilitaire/rust/src/
echo "shall we play a game ?"
if [[ $TERM == xterm ]]; then
		TERM=xterm-256color
fi
