
@echo off
if not exist "%1" goto usage

if exist "%1\.emacs" del "%1\.emacs"
if exist "%1\.emacs.d" rmdir "%1\.emacs.d"
if exist "%1\.inputrc" del "%1\.inputrc"

mklink "%1\.emacs" "%~dp0emacs"
mklink /D "%1\.emacs.d" "%~dp0emacs.d"

mklink "%1\.inputrc" "%~dp0inputrc"

goto exit

:usage
echo usage: install.bat home-dir

:exit
