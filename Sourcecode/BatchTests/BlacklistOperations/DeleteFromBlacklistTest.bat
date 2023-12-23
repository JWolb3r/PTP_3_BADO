@echo off
setlocal enabledelayedexpansion

@REM Test Case 1: Delete Blacklistpath
echo "%validBlacklistInput%">> "%blacklistFilePath%"
call "%deleteFromBlacklistBatchPath%" "%validBlacklistInput%"
set "testCaseIsSucessful=true"
for /f %%A in ("%blacklistFilePath%") do (
    if "%%~A" equ "%validBlacklistInput%" (
        set "testCaseIsSucessful=false"
    ) 
)
if "!errorlevel!" equ "0" if "%testCaseIsSucessful%" equ "true" (
    echo Test Case 1 successful: Path was successfully deleted.
) else (
    echo Test Case 1 failed: Path was not deleted.
)

@REM Test Case 2: Invalid Path to delete from Blacklist
call "%deleteFromBlacklistBatchPath%" "%inputBlacklistPath%"
if "!errorlevel!" equ "1" (
    echo Test Case 2 successful: Invalid blacklist input path recognized.
) else (
    echo Test Case 2 failed: Invalid blacklist input path was not recognized.
)

@echo All tests completed.
endlocal