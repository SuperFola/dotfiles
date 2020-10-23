#!/bin/bash

make_dotfiles() {
    cd /root
    git clone git@github.com:SuperFola/dotfiles.git

    if [ -d .bash-git-prompt ]; then rm -r .bash-git-prompt; fi
    ln -s dotfiles/.bash-git-prompt .bash-git-prompt

    if [ -d .vim ]; then rm -r .vim; fi
    ln -s dotfiles/.vim .vim

    if [ -f .vimrc ]; then rm .vimrc; fi
    ln -s dotfiles/.vimrc .vimrc

    if [ -f .gitconfig ]; then rm .gitconfig; fi
    ln -s dotfiles/.gitconfig .gitconfig

    if [ -f .bashrc ]; then mv .bashrc .bashrc.old; fi
    ln -s dotfiles/.bashrc .bashrc

    if [ -f .bash_aliases ]; then mv .bash_aliases .bash_aliases.old; fi
    ln -s dotfiles/.bash_aliases .bash_aliases

    if [ -f .selected_editor ]; then rm .selected_editor; fi
    ln -s dotfiles/.selected_editor .selected_editor

    if [ -f /etc/issue.net ]; then mv /etc/issue.net /etc/issue.net.old fi
    ln -s dotfiles/issue.net /etc/issue.net

    source .bashrc
}

if [ $# -eq 0 ]; then
    # installing packages
    apt update
    apt install -y htop git

    # creating ssh key
    ssh-keygen -b 2048 -t rsa -N "" -f /root/.ssh/id_rsa
    cat /root/.ssh/id_rsa.pub
    echo
    echo
    echo Please add this SSH key to your GitHub account before continuing
    read -p "Press enter to continue"

    make_dotfiles
elif [ $# -eq 1 ] && [[ $1 == "dotfiles" ]]; then
    make_dotfiles
fi

