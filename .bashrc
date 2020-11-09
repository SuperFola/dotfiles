# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

umask 0022

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

Color_Off='\033[0m'
Black='\033[0;30m'
Red='\033[0;31m'
Green='\033[0;32m'
Yellow='\033[0;33m'
Blue='\033[0;34m'
Purple='\033[0;35m'
Cyan='\033[0;36m'
White='\033[0;37m'

function prompt() {
    local ps1=""

    # standard prompt
    ps1="[${Green}\A\[$(tput sgr0)\]${Color_Off}] ${debian_chroot:+($debian_chroot)}"
    if [[ `whoami` == root ]]; then
        ps1="${ps1}${Purple}\u@\h${Color_Off}:${Cyan}\w${Color_Off}\n"
    else
        ps1="${ps1}${Cyan}\u@\h${Color_Off}:${Cyan}\w${Color_Off}\n"
    fi
    # adding screen status if we are in a screen
    if [ $STY ]; then
        ps1="${Red}[screen ${STY}]${Color_Off} ${ps1}"
    fi

    # git status
    local git_status="`git status -unormal 2>&1`"
    if ! [[ "$git_status" =~ not\ a\ git\ repo ]]; then
        # we are in a git repository

        if [[ "$git_status" =~ nothing\ to\ commit ]]; then
            # no changes
            local ansi=$Green
        elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
            # untracked files
            local ansi=$Red
        else
            # modifications + maybe untracked
            local ansi=$Yellow
        fi

        status_sb="`git status -sb 2>&1`"

        # number of commits ahed
        local ahead=""
        if [[ "$git_status" =~ Your\ branch\ is\ ahead\ of ]]; then
            ahead=" ↑`echo -e \"$status_sb\" | head -n 1 | egrep -o \"ahead [[:digit:]]+\" | cut -c 7-`"
        fi

        # count modified/deleted/untracked files
        local modified="~`echo -e \"$status_sb\" | grep -e '^[[:print:]]M' | wc -l`"
        local amodified="~`echo -e \"$status_sb\" | grep -e '^M' | wc -l`"
        local deleted="-`echo -e \"$status_sb\" | grep -e '^[[:print:]]D' | wc -l`"
        local adeleted="-`echo -e \"$status_sb\" | grep -e '^D' | wc -l`"
        local untracked="+`echo -e \"$status_sb\" | grep -e '^??' | wc -l`"
        local auntracked="+`echo -e \"$status_sb\" | grep -e '^A' | wc -l`"
        unset status_sb

        # get branch name
        if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
            branch=${BASH_REMATCH[1]}
        else
            # detached head
            branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null || echo HEAD`)"
        fi

        # set prompt
        branch="${ansi}${branch}${Color_Off}"
        local files_status="${Red}${untracked} ${modified} ${deleted}${Color_Off}"
        local afiles_status="${Green}${auntracked} ${amodified} ${adeleted}${Color_Off}"
        local files="${files_status} | ${afiles_status}"

        if ! [[ "$git_status" =~ nothing\ to\ commit ]]; then
            ps1="${ps1}[${branch} ${files}${ahead}]"
        else
            ps1="${ps1}[${branch}${ahead}]"
        fi
    else
        ps1="${ps1}$"
    fi

    # write prompt with -n (no trailing new line)
    echo -n $ps1
}

function _retcode() {
    # return code of the last command
    local retcode="$?"
    if [[ $retcode == 0 ]]; then
        retcode="${Green}✔${Color_Off}"
    else
        retcode="${Red}✖${retcode}${Color_Off}"
    fi

    echo -n $retcode
}

export PROMPT_COMMAND='export PS1="$(_retcode) $(prompt) ";'
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color'
    LS_COLORS=$LS_COLORS:'ow=1;34:' ; export LS_COLORS
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi
