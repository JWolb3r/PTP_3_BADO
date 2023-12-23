@echo off
setlocal enabledelayedexpansion

@REM Set up File and Hash for Test Case 1
if not exist "%dummyFilePath%" echo I am hashable!! >> "%dummyFilePath%"
@REM Test Case 1: Hash of File created
call "%duplicateDetectionBatchPath%" "%dummyFileName%"
set /a countOfHashfileContent=0
if exist "%hashFilePath%" (
    for /f "usebackq" %%A in ("%hashFilePath%") do (
        set /a countOfHashfileContent+=1
    )
)
if "!errorlevel!" equ "0" if "%countOfHashfileContent%" neq "0" (
    echo Test Case 1 successful: Hash of File created
) else (
    echo Test Case 1 failed: Hash of File was not created.
)

@REM Set up File and Hash for Test Case 2
if not exist "%dummyFilePath%" echo I am hashable!! >> "%dummyFilePath%"
@REM Test Case 2: Duplicate Detected
call "%duplicateDetectionBatchPath%" "%dummyFileName%"
if "!errorlevel!" equ "0" if exist "%destinationPathForDuplicateFiles%\Dummy-Folder\txt-Folder\Dummy.txt" (
    echo Test Case 2 successful: Duplicate Detected and moved to Duplicate Folder.
) else (
    echo Test Case 2 failed: Duplicate was not Detected and moved to Duplicate Folder.
) 

@REM Set up File and Hash for Test Case 3
if not exist "%dummyFilePath%" type nul >> "%dummyFilePath%"
@REM Test Case 3: Invalid File
call "%duplicateDetectionBatchPath%" "%dummyFileName%"
set "testCaseIsSucessful=false"
for /f "usebackq" %%A in ("%invalidFilePath%") do (
    if "%%~A" equ "%dummyFilePath%" (
        set "testCaseIsSucessful=true"
    )
)
if "!errorlevel!" equ "0" if "%testCaseIsSucessful%" equ "true" (
    echo Test Case 3 successful: Invalid File recognized and written to InvalidFile-txt.
) else (
    echo Test Case 3 failed: Invalid File was not recognized and written to InvalidFile-txt.
) 


@echo All tests completed.
endlocal