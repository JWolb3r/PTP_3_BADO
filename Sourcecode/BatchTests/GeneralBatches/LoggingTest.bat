@echo off
setlocal enabledelayedexpansion
set "testInformation=%date%,%time%"
call "%loggingBatchPath%" "%testInformation%"

@REM Test Case 1: Logging File exists
if exist "%loggingFilePath%" if "!errorlevel!" equ "0" (
    echo Test Case 1 successful: Logging File was created.
) else (
    echo Test Case 1 failed: Logging File was not created.
)

@REM Test Case 2: Test Information is in Loggin-File
set "testCaseIsSucessful=false"
for /f "usebackq delims=] tokens=1,*" %%A in ("%loggingFilePath%") do (
    if "%%B" equ ":%testInformation%" (
        set "testCaseIsSucessful=true"
    )
)
if "!testCaseIsSucessful!" equ "true" if "!errorlevel!" equ "0" (
    echo Test Case 2 successful: Logging Infomation is in Logging-File.
) else (
    echo Test Case 2 failed: Logging Infomation is not in Logging-File.
)

@echo All tests completed.
endlocal