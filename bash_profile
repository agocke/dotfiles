
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
   . $(brew --prefix)/etc/bash_completion
fi

if [ -f $(brew --prefix)/git/contrib/completion/git-completion.bash ]; then
    . $(brew --prefix)/git/contrib/completion/git-completion.bash
fi

alias ls='ls -hG'
