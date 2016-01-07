#!/bin/bash

pushd `dirname $0` > /dev/null
SCRIPTDIR=`pwd`
popd > /dev/null

ln -s "$SCRIPTDIR/vimrc" ~/.vimrc
ln -s "$SCRIPTDIR/vim"  ~/.vim
ln -s "$SCRIPTDIR/gitconfig" ~/.gitconfig
ln -s "$SCRIPTDIR/bashrc" ~/.bashrc
ln -s "$SCRIPTDIR/inputrc" ~/.inputrc
ln -s "$SCRIPTDIR/bash_profile" ~/.bash_profile
