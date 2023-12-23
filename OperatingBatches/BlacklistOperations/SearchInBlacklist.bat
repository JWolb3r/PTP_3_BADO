@echo off
setlocal
@REM SearchInBlacklist-Script Functionality:
@REM The script searches for the provided input path in the blacklist, after verifying its validity.
@REM %1=blacklistInputPath
set "blacklistInputPath=%~1"

call "%loggingBatchPath%" "Start '%searchInBlacklistBatchPath%' with Blacklist Search Path: '%blacklistInputPath%'."

@REM Validating the provided blacklist input path
call "%isValidFolderPathBatchPath%" "%blacklistInputPath%"
if "!errorlevel!" neq "0" (
    call "%loggingBatchPath%" "The given Blacklist Input Path '%blacklistInputPath%' is invalid."
    call "%loggingBatchPath%" "'%searchInBlacklistBatchPath%' terminates with error."
    exit /b 1 
)

@REM Loop through each line in the blacklist file
for /f "usebackq tokens=*" %%F in ("%blacklistFilePath%") do (
    @REM Check if the current line matches the provided blacklist input path
    if "%%~F" equ "%blacklistInputPath%" (
        call "%loggingBatchPath%" "Path '%blacklistInputPath%' is on Blacklist."
        call "%loggingBatchPath%" "'%searchInBlacklistBatchPath%' terminates with success."
        exit /b 0
    ) 
)

call "%loggingBatchPath%" "Path '%blacklistInputPath%' is not on Blacklist."
call "%loggingBatchPath%" "'%searchInBlacklistBatchPath%' terminates with error."
exit /b 1
endlocal
