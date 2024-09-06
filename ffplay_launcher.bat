@echo off
title FFplay Launcher

echo.
echo Welcome to FFplay Launcher!
echo.
echo Please select an option:
echo 1. Play video
echo 2. Play audio
echo 3. Play video in fullscreen
echo 4. Play video with audio disabled
echo 5. Play video with video disabled
echo 6. Play from URL
echo.

set /p option=Choose an option (1-6):

if "%option%"=="" goto end

echo.
set /p filePath=Enter the path or URL of the media file:

if "%filePath%"=="" goto end

echo.
echo You selected option %option% with file: %filePath%
echo.

set "ffplayPath=Lib\ffplay.exe"

if "%option%"=="1" (
    "%ffplayPath%" "%filePath%"
) else if "%option%"=="2" (
    "%ffplayPath%" -an "%filePath%"
) else if "%option%"=="3" (
    "%ffplayPath%" -fs "%filePath%"
) else if "%option%"=="4" (
    "%ffplayPath%" -an "%filePath%"
) else if "%option%"=="5" (
    "%ffplayPath%" -vn "%filePath%"
) else if "%option%"=="6" (
    "%ffplayPath%" "%filePath%"
) else (
    echo Invalid option selected.
)

:end
pause

::the ffplay executable should be in the same folder as the batchfile