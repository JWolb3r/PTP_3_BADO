@echo off
setlocal enabledelayedexpansion

@REM Test Case 1: Valid blacklist input path
call "%addToBlacklistBatchPath%" "%validBlacklistInput%"
set "testCaseIsSucessful=false"
for /f "usebackq" %%A in ("%blacklistFilePath%") do (
    if "%%~A" equ "%validBlacklistInput%" (
        set "testCaseIsSucessful=true"
    )
)
if "!errorlevel!" equ "0" if "%testCaseIsSucessful%" equ "true" (
    echo Test Case 1 successful: Valid blacklist input path was found in Blacklist.
) else (
    echo Test Case 1 failed: Valid blacklist input path was not found in Blacklist.
)

@REM Test Case 2: Invalid blacklist input path
call "%addToBlacklistBatchPath%" "%invalidBlacklistInput%"
if "!errorlevel!" equ "1" (
    echo Test Case 2 successful: Invalid blacklist input path recognized.
) else (
    echo Test Case 2 failed: Invalid blacklist input path was not recognized.
)

@REM Test Case 3: Path already in blacklist
call "%addToBlacklistBatchPath%" "%isOnBlacklist%"
if "!errorlevel!" equ "1" if exist "%blacklistFilePath%" (
    echo Test Case 3 successful: Path already in blacklist recognized.
) else (
    echo Test Case 3 failed: Path already in blacklist was not recognized.
)

@echo All tests completed.
endlocal