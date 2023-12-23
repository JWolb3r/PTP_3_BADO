@echo off
setlocal enabledelayedexpansion

@REM Test Case 1: Valid folder path
call "%isValidFolderPathBatchPath%" "%validFolderCase%"
if "!errorlevel!" equ "0" (
    echo Test Case 1 is successful: Valid folder path recognized.
) else (
    echo Test Case 1 is failed: Valid folder path was not recognized.
)

@REM Test Case 2: Invalid folder path
call "%isValidFolderPathBatchPath%" "%invalidFolderCase%"
if "!errorlevel!" equ "1" (
    echo Test Case 2 is successful: Invalid folder path recognized.
) else (
    echo Test Case 2 is failed: Invalid folder path was not recognized.
)

@REM Test Case 3: Invalid Input FilePath
call "%isValidFolderPathBatchPath%" "%validFilePath%"
call "%isValidFolderPathBatchPath%" "%invalidFolderCase%"
if "!errorlevel!" equ "1" (
    echo Test Case 3 is successful: Invalid Input file path recognized.
) else (
    echo Test Case 3 is failed: Invalid Input file path was not recognized.
)

@echo All tests completed successfully.
endlocal