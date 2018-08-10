#!/usr/bin/env bash

if [[ $(uname) == "Darwin" ]]; then
    eval $(/usr/libexec/path_helper -s)
fi

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
