if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -e ~/.git-prompt.sh ]; then
    . ~/.git-prompt.sh
fi

if [[ $(uname) =~ MINGW* ]]; then
    . ~/.bash_profile
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

