@echo off
setlocal enabledelayedexpansion

@REM Prepare Test Case 1
if not exist "%dummyFilePath%"  type nul >> "%dummyFilePath%"
@REM Test Case 1: Move file to the main folder
call "%fileSortingBatchPath%" "%dummyFileName%" "%sortedDummyFilesPath%"
if "!errorlevel!" equ "0" if exist "%dummyExtensionFolderPath%" (
    echo Test Case 1 successful: File moved to the main folder.
) else (
    echo Test Case 1 failed: File was not moved to the main folder.
)

@REM Prepare Test Case 2
if not exist "%dummyFilePath%" type nul >> "%dummyFilePath%"
@REM Test Case 2: Move file to the clonedFilesFolder
call "%fileSortingBatchPath%" "%dummyFileName%" "%sortedDummyFilesPath%"
if "!errorlevel!" equ "0" if exist "%dummyCloneFolderPath%\Dummy.txt" if exist "%dummyCloneFolderPath%\Dummy(1).txt" (
    echo Test Case 2 successful: File moved to the clonedFilesFolder.
) else (
    echo Test Case 2 failed: File was not moved to the clonedFilesFolder.
)

@REM Prepare Test Case 3
if not exist "%dummyFilePath%" type nul >> "%dummyFilePath%"
@REM Test Case 3: Move file to the clonedFilesFolder with counted File Name
call "%fileSortingBatchPath%" "%dummyFileName%" "%sortedDummyFilesPath%"
if "!errorlevel!" equ "0" if exist "%dummyCloneFolderPath%\Dummy(2).txt" (
    echo Test Case 3 successful: File moved to the clonedFilesFolder with counted Filename.
) else (
    echo Test Case 3 failed: File was not moved to the clonedFilesFolder with counted Filename.
)
@echo All tests completed.
endlocal