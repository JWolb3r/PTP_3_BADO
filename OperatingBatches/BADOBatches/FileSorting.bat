@echo off
setlocal enabledelayedexpansion
@REM File Sorting Script Functionality:
@REM This script takes an input file, generates multiple local variables using the "~" operator and the file name.
@REM The script organizes the file into the correct folder.
@REM %1 = file, %2 = destination_Path
@REM Set up local variables
set inputFile=%~1
set inputFileName=%~n1
set inputFilePath=%~dp1
set inputFilePathNameExtension=%~dpnx1
set extension=%~x1
set extensionFolder=%~2\%extension:.=%-Folder
set namesFolder=%extensionFolder%\%~n1-Files

@REM Create the main folder if it doesn't exist
if not exist "%extensionFolder%" (
    mkdir "%extensionFolder%"
)

@REM Check if the clonedFilesFolder exists
if exist "%namesFolder%" (
    set count=0
    @REM Count the number of files in the clonedFilesFolder
    for /f %%F in ('dir "%namesFolder%" /a-d /b') do (
        set /a count+=1
    )
    @REM Create an updatedFileName with the count
    set "updatedFileName=%inputFileName%(!count!)%extension%"
    @REM Rename the original file with the updatedFileName
    rename "%inputFile%" "!updatedFileName!"
    set "updatedFileNamePath=%inputFilePath%!updatedFileName!"
    @REM Move the renamed file to the clonedFilesFolder
    move "!updatedFileNamePath!" "%namesFolder%"
    call %loggingBatchPath% "Moved '!updatedFileNamePath!' to '%namesFolder%'."
) else if exist "%extensionFolder%\%~1" (
    @REM If the clonedFilesFolder doesn't exist, create it
    set "updatedFileName=%inputFileName%(1)%extension%"
    mkdir "%namesFolder%"
    @REM Move the original file to the clonedFilesFolder
    move "%extensionFolder%\%~nx1" "%namesFolder%"
    @REM Rename the original file with the updatedFileName
    rename "%inputFile%" "!updatedFileName!"
    set "updatedFileNamePath=%inputFilePath%!updatedFileName!"
    @REM Move the renamed file to the clonedFilesFolder
    move "!updatedFileNamePath!" "%namesFolder%"
    call %loggingBatchPath% "Moved '!updatedFileNamePath!' to '%namesFolder%'."
) else (
    @REM If the original file is not in the main folder or the clonedFilesFolder, move it to the extensionFolder
    move "%inputFilePathNameExtension%" "%extensionFolder%"
    call %loggingBatchPath% "Moved '%inputFilePathNameExtension%' to '%extensionFolder%'."
)

endlocal
exit /b 0