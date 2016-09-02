set scriptDir=%~dp0

if exist %HOME%\vimfiles ( move %HOME%\vimfiles %HOME%\vimfiles.%date:~0,4%%date:~5,2%%date:~8,2% )

xcopy /E /C /H %scriptDir:~0,-1% %HOME%\vimfiles
