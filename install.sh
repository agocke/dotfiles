#!/bin/sh

TARGETDIR=$1

if [ ! -d $TARGETDIR ]; then
  echo "Target directory does not exist"
  exit 1
fi

pushd `dirname $0` > /dev/null
SCRIPTDIR=`pwd`
popd > /dev/null

ln -s "$SCRIPTDIR/vimrc" "$TARGETDIR/.vimrc"
ln -s "$SCRIPTDIR/vim"  "$TARGETDIR/.vim"
ln -s "$SCRIPTDIR/gitconfig" "$TARGETDIR/.gitconfig"
