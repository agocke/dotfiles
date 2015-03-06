
@echo off
if not exist "%1" goto usage

mklink "%1\.emacs" "%~dp0emacs"
mklink "%1\.emacs.d" "%~dp0emacs.d"

mklink "%1\.zshrc" "%~dp0zshrc"
mklink "%1\.oh-my-zsh" "%~dp0oh-my-zsh"

goto exit

:usage
echo usage: install.bat home-diro

:exit
