#!/usr/bin/env bash

if [ -e ~/.bashrc ]; then
    . ~/.bashrc
fi

export CLICOLOR=1
ls --color=auto &> /dev/null && alias ls='ls --color=auto'
