if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -e ~/.git-prompt.sh ]; then
    . ~/.git-prompt.sh
fi

# Configure ssh-agent

os=$(uname)
env=~/.ssh/agent.env

agent_load_env() { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

if [[ "$os" =~ MINGW* ]]; then
    agent_load_env

    # agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
    agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

    if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
        agent_start
        ssh-add
    elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
        ssh-add
    fi

    unset env
fi

PS1='\[\033]0;:${PWD//[^[:ascii:]]/?}\007\]' # set window title
PS1="$PS1"'\n'              # new line
PS1="$PS1"'\[\033[32m\]'    # change to green
PS1="$PS1"'\u@\h '          # user@host<space>
PS1="$PS1"'\[\033[35m\]'    # change to purple
PS1="$PS1"'$MSYSTEM '       # show MSYSTEM
PS1="$PS1"'\[\033[33m\]'    # change to brownish yellow
PS1="$PS1"'\w'              # current working directory
PS1="$PS1"'\[\033[36m\]'    # change to light blue
PS1="$PS1"'`__git_ps1`'     # print Git info
PS1="$PS1"'\[\033[0m\]\n$ ' # change back to default color

