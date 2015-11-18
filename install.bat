
@echo off
if not exist "%1" goto usage

if exist "%1\.vimrc" del "%1\.vimrc"
if exist "%1\.vim" rmdir "%1\.vim"
if exist "%1\.inputrc" del "%1\.inputrc"
if exist "%1\.gitconfig" del "%1\.gitconfig"
if exist "%1\.bashrc" del "%1\.bashrc"
if exist "%1\vs-bash.bat" del "%1\vs-bash.bat"

mklink "%1\.vimrc" "%~dp0vimrc"
mklink /D "%1\.vim" "%~dp0vim"

mklink "%1\.inputrc" "%~dp0inputrc"
mklink "%1\.gitconfig" "%~dp0gitconfig"
mklink "%1\.bashrc" "%~dp0bashrc"
mklink "%1\vs-bash.bat" "%~dp0vs-bash.bat"

goto exit

:usage
echo usage: install.bat home-dir

:exit
