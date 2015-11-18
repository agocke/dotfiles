@echo off

if exist "%UserProfile%\.vimrc" del "%UserProfile%\.vimrc"
if exist "%UserProfile%\.vim" rmdir "%UserProfile%\.vim"
if exist "%UserProfile%\.inputrc" del "%UserProfile%\.inputrc"
if exist "%UserProfile%\.gitconfig" del "%UserProfile%\.gitconfig"
if exist "%UserProfile%\.bashrc" del "%UserProfile%\.bashrc"
if exist "%UserProfile%\.bash_profile" del "%UserProfile%\.bash_profile"
if exist "%UserProfile%\vs-bash.bat" del "%UserProfile%\vs-bash.bat"

mklink "%UserProfile%\.vimrc" "%~dp0vimrc"
mklink /D "%UserProfile%\.vim" "%~dp0vim"

mklink "%UserProfile%\.inputrc" "%~dp0inputrc"
mklink "%UserProfile%\.gitconfig" "%~dp0gitconfig"
mklink "%UserProfile%\.bashrc" "%~dp0bashrc"
mklink "%UserProfile%\.bash_profile" "%~dp0bash_profile"
mklink "%UserProfile%\vs-bash.bat" "%~dp0vs-bash.bat"

goto exit

:usage
echo usage: install.bat home-dir

:exit
