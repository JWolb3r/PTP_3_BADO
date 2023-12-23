@echo off
setlocal enabledelayedexpansion
@REM DeleteFromBlacklist-Script Functionality:
@REM The script deletes the given folder path from the blacklist, if the path is valid.
@REM %1=inputBlacklistPath
set "inputBlacklistPath=%~1"
set "blacklistNameExtension="
set "txtFileClonePath="

call "%loggingBatchPath%" "Start '%deleteFromBlacklistBatchPath%' with Blacklist Input Path: '%inputBlacklistPath%'."

@REM Validating the provided blacklist path
call "%isValidFolderPathBatchPath%" "%inputBlacklistPath%"
if "!errorlevel!" neq "0" (
    call "%loggingBatchPath%" "The given Blacklist Path '%inputBlacklistPath%' is invalid."
    call "%loggingBatchPath%" "'%deleteFromBlacklistBatchPath%' terminates with error."
    exit /b 1 
)

@REM Extracting information about the blacklist file and its clone
for %%F in ("%blacklistFilePath%") do (
    set "txtFileClonePath=%%~dpF^Clone%%~nxF"
    set "blacklistNameExtension=%%~nxF"
)

@REM Loop through each line in the original blacklist file
for /f "usebackq tokens=*" %%F in ("%blacklistFilePath%") do (
    @REM Check if the current line is not equal to the provided input blacklist path
    if "%%~F" neq "%inputBlacklistPath%" (
        @REM Append the line to the cloned blacklist file
        echo "%%~F">> "%txtFileClonePath%"
    )
)

@REM Delete the original blacklist file and rename the cloned file to replace it
del "%blacklistFilePath%" 
rename "!txtFileClonePath!" "%blacklistNameExtension%"

call "%loggingBatchPath%" "'%blacklistFilePath%' has been replaced with the updated clone."
call "%loggingBatchPath%" "'%inputBlacklistPath%' has been deleted from '%blacklistFilePath%'."
call "%loggingBatchPath%" "'%deleteFromBlacklistBatchPath%' terminates with success."
exit /b 0
endlocal
