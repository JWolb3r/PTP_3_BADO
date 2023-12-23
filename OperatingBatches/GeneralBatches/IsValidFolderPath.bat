@echo off
setlocal enabledelayedexpansion
@REM IsValidFolderPath-Script Functionality:
@REM Tests if the provided folder path is valid.
@REM %1 = folderPath
set "folderPath=%~1"

call "%loggingBatchPath%" "Start '%isValidFolderPathBatchPath%' with Folder Path: '%folderPath%'."

@REM Check if the path exists
if exist "%folderPath%" (
    @REM Verify whether the path refers to a file or folder
    if "%~x1" == "" (
        call "%loggingBatchPath%" "Folder Path '%folderPath%' is valid."
        call "%loggingBatchPath%" "'%isValidFolderPathBatchPath%' terminates with success."
        exit /b 0
    )
)

call "%loggingBatchPath%" "Folder Path '%folderPath%' is invalid."
call "%loggingBatchPath%" "'%isValidFolderPathBatchPath%' terminates with error."
exit /b 1
endlocal
