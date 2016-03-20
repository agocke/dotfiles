#!/bin/bash

pushd `dirname $0` > /dev/null
SCRIPTDIR=`pwd`
popd > /dev/null

install_file()
{
    local target=~/.$1
    echo "Installing $target"
    if [ -h $target ]; then
        echo "Found symbolic link"
        rm $target
    fi
    ln -s "$SCRIPTDIR/$1" $target
}

install_file vimrc
install_file vim
install_file gitconfig
install_file bashrc
install_file inputrc
install_file bash_profile
