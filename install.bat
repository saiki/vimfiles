@echo off
set scriptDir=%~dp0

if exist %HOME%\vimfiles ( move %HOME%\vimfiles %HOME%\vimfiles.%date:~0,4%%date:~5,2%%date:~8,2% )

copy %scriptDir% %HOME%\vimfiles
@echo on
