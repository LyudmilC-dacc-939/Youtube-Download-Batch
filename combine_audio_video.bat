@echo off
::this is used to handle non-latin letters, in name of both video and audio files
chcp 65001 >nul
setlocal enabledelayedexpansion

:: Define the path to the FFmpeg executable
set "ffmpeg_path=%~dp0Lib\ffmpeg.exe"

:: Check if FFmpeg exists
if not exist "%ffmpeg_path%" (
    echo FFmpeg executable not found in the Lib folder.
    pause
    exit /b 1
)

:: Ask user for folder containing files
set "folder="
set /p "folder=Paste the full path to the folder containing your files: "

:: Remove trailing backslashes from the folder path
if "%folder:~-1%"=="\" set "folder=%folder:~0,-1%"

:: Verify folder exists
if not exist "%folder%" (
    echo Folder does not exist.
    pause
    exit /b 1
)

:: Navigate to the specified folder
pushd "%folder%" || (
    echo Failed to navigate to the folder.
    pause
    exit /b 1
)

:: Ask user for video file
set "video="
set /p "video=Enter the name of the video file (e.g., video.mp4 or video.mpeg): "

:: Remove surrounding quotes from video filename if present
set "video=%video:"=%"

:: Check if video file exists
if not exist "%video%" (
    echo Video file "%video%" does not exist in "%folder%".
    pause
    popd
    exit /b 1
)

:: Ask user for audio file
set "audio="
set /p "audio=Enter the name of the audio file (e.g., audio.mp3): "

:: Remove surrounding quotes from audio filename if present
set "audio=%audio:"=%"

:: Check if audio file exists
if not exist "%audio%" (
    echo Audio file "%audio%" does not exist in "%folder%".
    pause
    popd
    exit /b 1
)

:: Ask user for video codec
set "video_codec="
set /p "video_codec=Enter the video codec (e.g., libx264 for H.264, copy to keep original): "

:: Ask user for audio codec
set "audio_codec="
set /p "audio_codec=Enter the audio codec (e.g., aac, copy to keep original): "

:: Ask user for the output file name
set "output="
set /p "output=Enter the name for the output file (e.g., output.mp4): "

:: Ensure that the output file name includes the .mp4 extension
if not "%output:~-4%"==".mp4" (
    set "output=%output%.mp4"
)

:: Ensure that the output file name does not already exist
if exist "%output%" (
    echo Output file "%output%" already exists. Please delete or rename it before running the script.
    pause
    popd
    exit /b 1
)

:: Run FFmpeg to merge video and audio with specified codecs
"%ffmpeg_path%" -i "%video%" -i "%audio%" -c:v %video_codec% -c:a %audio_codec% "%output%"

:: Check if FFmpeg command was successful
if %errorlevel% neq 0 (
    echo FFmpeg encountered an error. Please check the provided parameters and file paths.
    pause
    popd
    exit /b 1
)

echo Merge complete. Output file: %output%
pause
popd