@echo off
setlocal
@REM Empty Folder Detection Script Functionality:
@REM This script accepts an input folder, iterates through its contents and counts the items within the folder.
@REM The script is successful if the folder is empty.
@REM %1 = Folder Path
set "folderPath=%~1"
call "%loggingBatchPath%" "Start '%emptyFolderDetectionBatchPath%' with Input Folder: '%folderPath%'."

@REM Initialize a counter for files and folders
set /a count=0 

@REM Loop through each item in the specified directory and increment the count
for /f %%f in ('dir "%folderPath%\*" /b') do (
    set /a count+=1
)

@REM Check if the count is zero
if "%count%" equ "0" (
    @REM Log that the folder is empty and write the empty folder path to the specified file
    echo "%~1">> "%emptyFolderFilePath%"
    call "%loggingBatchPath%" "Folder '%folderPath%' is Empty. Empty Folder Path has been written to '%emptyFolderFilePath%'."
    call "%loggingBatchPath%" "'%emptyFolderDetectionBatchPath%' terminates with success."
    exit /b 0
) else (
    @REM Log that the folder is not empty and "return" the count of files and folders as errorlevel
    call "%loggingBatchPath%" "Folder '%folderPath%' is not Empty. Folder contains '%count%' Files and Folders."
    call "%loggingBatchPath%" "'%emptyFolderDetectionBatchPath%' terminates with error."
    exit /b 1
)
endlocal
