@echo off
setlocal enabledelayedexpansion

@REM Test Case 1: Path is in Blacklist
call "%searchInBlacklistBatchPath%" "%isOnBlacklist%"
if "!errorlevel!" equ "0" (
    echo Test Case 1 successful: Path who exists on Blacklist was found.
) else (
    echo Test Case 1 failed: Path who exists on Blacklist was not found.
)

@REM Test Case 2: Path is not in Blacklist
call "%searchInBlacklistBatchPath%" "%isNotInBlacklist%"
if "!errorlevel!" equ "1" (
    echo Test Case 2 successful: Path who does not exists on Blacklist was not found.
) else (
    echo Test Case 2 failed: Path who does not exists on Blacklist was found.
)

@echo All tests completed.
endlocal