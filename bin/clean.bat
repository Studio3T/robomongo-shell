@echo off 
setlocal enableextensions enabledelayedexpansion

rem -----------------------------------
rem - Configuration
rem -----------------------------------

rem Path to bin and project folder
set BIN_DIR_WITH_BACKSLASH=%~dp0%
set BIN_DIR=%BIN_DIR_WITH_BACKSLASH:~0,-1%
set PROJECT_DIR=%BIN_DIR%\..

rem Set path according to build type
rem "\opt" for release, "\debug" for debug mode
SET BUILD_PATH=opt
if "%1%"=="debug" (
  SET BUILD_PATH=debug
)

rem Target folder where build will be placed
set TARGET=%PROJECT_DIR%\build\%BUILD_PATH%

rem Remove target folder
rmdir /s /q %TARGET%
if %ERRORLEVEL% neq 0 (
  echo.
  echo Error when removing !TARGET!.
  exit /b 1
  pause
)