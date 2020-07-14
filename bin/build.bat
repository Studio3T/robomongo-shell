@echo off
setlocal enableextensions enabledelayedexpansion

rem -----------------------------------
rem - Configuration
rem -----------------------------------

rem Path to bin and project folder
set BIN_DIR_WITH_BACKSLASH=%~dp0%
set BIN_DIR=%BIN_DIR_WITH_BACKSLASH:~0,-1%
set PROJECT_DIR=%BIN_DIR%\..

rem Set build type
SET BUILD_TYPE_STR=release
SET BUILD_OBJECTS_DIR=build\opt
if "%1%"=="debug" (
  SET BUILD_TYPE=--dbg
  SET BUILD_TYPE_STR=debug
  SET BUILD_OBJECTS_DIR=build\debug
)

rem -----------------------------------
rem - Execution
rem -----------------------------------

cd "%PROJECT_DIR%

rem Build mongo shell
echo -------------------------------------
echo Building in %BUILD_TYPE_STR% mode:
echo -------------------------------------
scons mongo.exe %BUILD_TYPE% -j8 --link-model=object --disable-minimum-compiler-version-enforcement && ^
echo ------------------------------------- END OF BUILD && ^
rem End of build

rem This code block copies build objects into a directory specified in "MongoDB_OBJECTS"
if defined MongoDB_OBJECTS ( 
  echo Found MongoDB_OBJECTS environment variable. Copying object files...
  echo This may take a couple of minutes. Please wait...
  robocopy ..\%BUILD_OBJECTS_DIR% %MongoDB_OBJECTS%\\%BUILD_OBJECTS_DIR% /MIR /NFL /NDL
)