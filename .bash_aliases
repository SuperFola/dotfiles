# defined only for WSL
if grep -qEi "(microsoft|wsl)" /proc/version; then
    # mount windows usb disks
    mount_drvfs() {
        if [ $# -eq 1 ]; then
            mount -t drvfs $1: /mnt/$1
        fi
    }
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias stus='git status -sb'
alias commit='git commit -S -m'
alias log='git log --oneline -n'
alias matrix='cols=$(($(tput cols) / 5 - 1)) ; echo -e "\e[32m"; while :; do for i in $(seq 1 $cols); do r="$(($RANDOM % 2))"; if [[ $(($RANDOM % 5)) == 1 ]]; then if [[ $(($RANDOM % 4)) == 1 ]]; then v+="\e[1m $r   "; else v+="\e[2m $r   "; fi; else v+="     "; fi; done; echo -e "$v"; v=""; done'
alias nano='nano -gEScl -T4'
alias ls-pkg-size='dpkg-query -Wf '"'"'${Installed-Size}\t${Package}\n'"'"' | sort -nr'
alias prettyjson='python -m json.tool'

# on WSL, nodejs and npm are in ~/.node
# and the path must be changed to use my firefox as a browser
if grep -qEi "(microsoft|wsl)" /proc/version; then
    alias node='~/.node/bin/node'
    alias npm='~/.node/bin/npm'
    export PATH="$PATH:/home/folaefolc/.node/bin/"
    export PATH="$PATH:/mnt/c/Program Files/Mozilla Firefox"
    export BROWSER=firefox.exe
fi
