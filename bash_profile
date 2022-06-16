#!/usr/bin/env bash

source ~/.profile

if [[ $(uname) == "Darwin" ]]; then
    eval $(/usr/libexec/path_helper -s)
fi

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
