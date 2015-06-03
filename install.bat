
@echo off
if not exist "%1" goto usage

if exist "%1\.vimrc" del "%1\.vimrc"
if exist "%1\.vim" rmdir "%1\.vim"
if exist "%1\.inputrc" del "%1\.inputrc"

mklink "%1\.vimrc" "%~dp0vimrc"
mklink /D "%1\.vim" "%~dp0vim"

mklink "%1\.inputrc" "%~dp0inputrc"

goto exit

:usage
echo usage: install.bat home-dir

:exit
