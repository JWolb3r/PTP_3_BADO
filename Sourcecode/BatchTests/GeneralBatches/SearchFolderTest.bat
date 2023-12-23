@echo off
setlocal enabledelayedexpansion
@REM Test Case 1: Valid Path to Search In
call "%searchFolderBatchPath%" "%batchTestsPath%" "GeneralBatchesTestFiles"
if "!errorlevel!" equ "0" (
    echo Test Case 1 successful: Valid Path to search Folder in is recognized as valid.
) else (
    echo Test Case 1 failed: Error occured while Testing Path to Search In.
)

@REM Test Case 2: Check if non existing Folder was not found
call "%searchFolderBatchPath%" "%batchTestsPath%" "%invalidFolderCase%"
if "!errorlevel!" equ "1" (
    echo Test Case 2 successful: No founded folders recognized.
) else (
    echo Test Case 2 failed: Folder who does not exist was found.
)

@REM Test Case 3: Check if existing Folder was found
call "%searchFolderBatchPath%" "%batchTestsPath%" "%validFolderCase%"
if "!errorlevel!" equ "1" (
    echo Test Case 3 successful: Folder was found.
) else (
    echo Test Case 3 failed: Unexpected result.
)

@echo All tests completed.
endlocal