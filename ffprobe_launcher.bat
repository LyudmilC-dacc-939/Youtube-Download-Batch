@echo off
title FFprobe Launcher

echo.
echo Welcome to FFprobe Launcher!
echo.
echo Please select an option:
echo 1. Show basic info
echo 2. Show detailed info
echo 3. Show stream info
echo 4. Show format info
echo.

set /p option=Choose an option (1-4):

if "%option%"=="" goto end

echo.
set /p filePath=Enter the path or URL of the media file:

if "%filePath%"=="" goto end

echo.
echo You selected option %option% with file: %filePath%
echo.

set "ffprobePath=Lib\ffprobe.exe"

if "%option%"=="1" (
    "%ffprobePath%" -v error -show_format -show_streams "%filePath%"
) else if "%option%"=="2" (
    "%ffprobePath%" -v error -show_format -show_streams -pretty "%filePath%"
) else if "%option%"=="3" (
    "%ffprobePath%" -v error -show_streams "%filePath%"
) else if "%option%"=="4" (
    "%ffprobePath%" -v error -show_format "%filePath%"
) else (
    echo Invalid option selected.
)

:end
pause