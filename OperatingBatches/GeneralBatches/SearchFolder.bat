@echo off
setlocal enabledelayedexpansion
@REM SearchFolder-Scipt Functionality:
@REM Searches for the specified folder name in the provided folder path and its subdirectories.
@REM %1 = startSearchingPath, %2 = searchedFolder
set "startSearchingPath=%~1"
set "searchedFolder=%~2"
set /a foundedFoldersCount=0
call "%loggingBatchPath%" "Start '%searchFolderBatchPath%' with searched Folder: '%searchedFolder%', start searching Path: '%startSearchingPath%'."
@REM Validate if the start searching path is a valid folder path
call "%isValidFolderPathBatchPath%" "%startSearchingPath%"
if "!errorlevel!" neq "0" (
    call "%loggingBatchPath%" "The start searching Path '%startSearchingPath%' is invalid."
    call "%loggingBatchPath%" "'%searchFolderBatchPath%' terminates with error."
    exit /b 1
)

call "%loggingBatchPath%" "Der Ordner '%searchedFolder%' wird in dem Pfad '%startSearchingPath%' gesucht."
@REM Loop through all subdirectories in the specified folder
echo SearchFolder Run [%date%, %time%]:>> %foundedFoldersFilePath%
for /r "%startSearchingPath%" /d %%F in (*) do (
    @REM Check if the current subdirectory name matches the specified destination folder
    if "%%~nF" equ "%~2" (
        @REM Append the full path of the matched subdirectory to the specified file
        echo "%%~dpnF">> %foundedFoldersFilePath%
        set /a foundedFoldersCount+=1
    )
)

@REM Check if any folders were found
if "%foundedFoldersCount%" equ "0" (
    echo SearchFolder.bat didnt find any Folder with the Name '%searchedFolder%' in Path '%startSearchingPath%'.>> "%foundedFoldersFilePath%"
    echo.>> %foundedFoldersFilePath%
    call "%loggingBatchPath%" "No Folders with name '%searchedFolder%' found in '%startSearchingPath%'"
    call "%loggingBatchPath%" "'%searchFolderBatchPath%' terminates with success."
    exit /b 1
) else (
    echo SearchFolder.bat finished successfully with '%foundedFoldersCount%' founded Folders.>> "%foundedFoldersFilePath%"
    echo.>> "%foundedFoldersFilePath%"
    call "%loggingBatchPath%" "Die Ergebnisse nach der Suche des Ordners '%searchedFolder%' sind in '%foundedFoldersFilePath%' aufgelistet."
    call "%loggingBatchPath%" "'%searchFolderBatchPath%' terminates with success."
    exit /b 0
)

endlocal
