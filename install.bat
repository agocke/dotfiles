
@echo off
if not exist "%1" goto usage

mklink "%1\.emacs" "%~dp0emacs"
mklink /D "%1\.emacs.d" "%~dp0emacs.d"

:usage
echo usage: install.bat home-dir

:exit
