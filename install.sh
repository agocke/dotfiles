#!/bin/sh

TARGETDIR=$1

if [ ! -d $TARGETDIR ]; then
  echo "Target directory does not exist"
  exit 1
fi

SCRIPTDIR=$(dirname $0)

ln -s "$SCRIPTDIR/emacs" "$TARGETDIR/.emacs" 
ln -s "$SCRIPTDIR/emacs.d"  "$TARGETDIR/.emacs.d" 

ln -s "$SCRIPTDIR/zshrc" "$TARGETDIR/.zshrc" 
ln -s "$SCRIPTDIR/oh-my-zsh" "$TARGETDIR/.oh-my-zsh" 
