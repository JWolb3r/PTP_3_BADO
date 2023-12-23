@echo off
setlocal enabledelayedexpansion
@REM Test Case 1: Empty folder
call "%emptyFolderDetectionBatchPath%" "%emptyFolderPath%"
if "!errorlevel!" equ "0" (
    echo Test Case 1 successful: Empty folder recognized.
) else (
    echo Test Case 1 failed: Empty folder was not recognized.
)

@REM Test Case 2: Non-empty folder
call "%emptyFolderDetectionBatchPath%" "%folderWithFiles%"
if "!errorlevel!" equ "1" (
    echo Test Case 2 successful: Non-empty folder recognized.
) else (
    echo Test Case 2 failed: Non-empty folder was not recognized.
)
endlocal