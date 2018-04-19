#!/usr/bin/env bash

# MINGW doesn't automatically use an interactive shell, so bashrc isn't
# imported
os=$(uname)
if [[ "$os" =~ MINGW* ]]; then
    source ~/.bashrc
fi

export CLICOLOR=1
ls --color=auto &> /dev/null && alias ls='ls --color=auto'

if [[ $(uname) == "Darwin" ]]; then
    eval $(/usr/libexec/path_helper -s)
fi

if ! [[ $(uname) =~ MINGW* ]]; then
    . ~/.bashrc
fi

# Configure ssh-agent

env=~/.ssh/agent.env

agent_load_env() { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add -t 3600 # expire after 1 hour
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add -t 3600 # expire after 1 hour
fi

unset env
