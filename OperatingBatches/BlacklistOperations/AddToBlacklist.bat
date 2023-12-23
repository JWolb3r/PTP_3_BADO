@echo off
setlocal enabledelayedexpansion
@REM AddToBlacklist-Script Functionality:
@REM The script accepts a folder path as input and adds it to the blacklist if the path is valid and not already on the blacklist.
@REM %1 = blacklistInputPath
set "blacklistInputPath=%~1"

call "%loggingBatchPath%" "Start '%addToBlacklistBatchPath%' with Blacklist Input Path: '%blacklistInputPath%'."

@REM Validating the provided blacklist input path
call "%isValidFolderPathBatchPath%" "%blacklistInputPath%"
if "!errorlevel!" neq "0" (
    call "%loggingBatchPath%" "The given Blacklist Input Path '%blacklistInputPath%' is invalid."
    call "%loggingBatchPath%" "'%addToBlacklistBatchPath%' terminates with error."
    exit /b 1 
)

@REM Check if the provided blacklist input path is already in the blacklist file
call "%searchInBlacklistBatchPath%" "%blacklistInputPath%"
if "!errorlevel!" equ "0" (
    call "%loggingBatchPath%" "The given Blacklist Input Path '%blacklistInputPath%' already is on '%blacklistFilePath%'."
    call "%loggingBatchPath%" "'%addToBlacklistBatchPath%' terminates with error."
    exit /b 1 
)

@REM Append the provided blacklist input path to the blacklist file
echo "%blacklistInputPath%">> "%blacklistFilePath%"

call "%loggingBatchPath%" "'%blacklistInputPath%' has been added to '%blacklistFilePath%'."
call "%loggingBatchPath%" "'%addToBlacklistBatchPath%' terminates with success."
exit /b 0
endlocal
