@echo off
setlocal enabledelayedexpansion
@REM BADO-Script Functionality:
@REM This script takes an input path, a destination path, and a Argument indicating if the script should work recursively or not.
@REM The script iterates through the provided input path, sorts the files by extension, searches for empty folders and writes their names to a text file. Additionally, it looks for duplicate files within the sorted files.
@REM In the final step, the script removes all created folders that are empty after the duplicate detection.
@REM If the recursive flag is set, BADO will invoke itself in the Run_Through_Path_Sort_And_Search_Empty_Folders sub-batch and run through the sub-folders of the given path.
@REM %1 =inputPath, %2 = destinationPath, %3 = recursive or not (r\)
set "inputPath=%~1"
set "destinationPath=%~2"
set "recursive=%~3"

@REM Start the Run_Through_Path_Sort_And_Search_Empty_Folders subroutine
call "%loggingBatchPath%" "Start '%BADOBatchPath%' with Input Path to run BADO in: '%inputPath%', and Destination Path for operated Files: '%destinationPath%' and recursive Flag: '%recursive%'."
if /i "%recursive%" equ "r" (
    call "%loggingBatchPath%" "BADO will run recursively, through all folders in the given path."
) else (
    call "%loggingBatchPath%" "BADO will only run through Files and Folders in the given path."
)

@REM Check the validity of the destinationPath
call "%isValidFolderPathBatchPath%" "%destinationPath%"
if "!errorlevel!" neq "0" (
    call "%loggingBatchPath%" "Your given Destination Path '%destinationPath%' for the Sorted and Duplicate files is invalid."
    call "%loggingBatchPath%" "'%BADOBatchPath%' terminates with error."
    exit /b 1
)

@REM Call the BADOSetUp.bat script to set up BADOBatches environment variables
call  "%BADOSetUpBatchPath%" "%destinationPath%"

@REM Call the Run_Through_Path_Sort_And_Search_Empty_Folders
call :Run_Through_Path_Sort_And_Search_Empty_Folders "%inputPath%"
@REM Check the success of Run_Through_Path_Sort_And_Search_Empty_Folders subroutine
if "!errorlevel!" neq "0" (
    call "%loggingBatchPath%" "An Error occurred in Run_Through_Path_Sort_And_Search_Empty_Folders of '%BADOBatchPath%' in '%inputPath%'."
    call "%loggingBatchPath%" "'%BADOBatchPath%' terminates with error."
    exit /b 1
)

@REM Call the Duplicate_Detection_BADO
call :Duplicate_Detection_BADO
@REM Check the success of duplicate detection
if "!errorlevel!" neq "0" (
    call "%loggingBatchPath%" "'%BADOBatchPath%' terminates with error."
    exit /b 1
)

call "%loggingBatchPath%" "Start Run_Through_DestinationPathForSortedFiles_And_Search_For_EmptyFolders of '%BADOBatchPath%' on '%destinationPathForSortedFiles%'."
@REM call :Run_Through_DestinationPathForSortedFiles_And_Search_For_EmptyFolders

@REM End the BADO subroutine and return to the base folder
call "%loggingBatchPath%" "'%BADOBatchPath%' terminates with success."
cd "%basePath%"
exit /b 0

:Run_Through_Path_Sort_And_Search_Empty_Folders
@REM Start the Run_Through_Path_Sort_And_Search_Empty_Folders subroutine
call "%loggingBatchPath%" "Start 'Run_Through_Path_Sort_And_Search_Empty_Folders' of '%BADOBatchPath%' on '%inputPath%'"

@REM Check the validity of the inputPath
call "%isValidFolderPathBatchPath%" "%inputPath%"
if "!errorlevel!" neq "0" (
    call "%loggingBatchPath%" "An Error occurred in 'Run_Through_Path_Sort_And_Search_Empty_Folders' of '%BADOBatchPath%' in IsValidFolderPath.bat of File '%inputPath%'."
    call "%loggingBatchPath%" "'Run_Through_Path_Sort_And_Search_Empty_Folders' terminates with error."
    exit /b 1
)

@REM Search the blacklist for the input path
call "%searchInBlacklistBatchPath%" "%inputPath%"
if "!errorlevel!" equ "0" (
    call "%loggingBatchPath%" "'%BADOBatchPath%' cannot run 'Run_Through_Path_Sort_And_Search_Empty_Folders' on '%inputPath%' because the path is on the blacklist."
    call "%loggingBatchPath%" "'Run_Through_Path_Sort_And_Search_Empty_Folders' terminates with error."
    exit /b 1
)

@REM Run emptyFolderDetection on the input path
call "%emptyFolderDetectionBatchPath%" "%inputPath%"
if "!errorlevel!" equ "0" (
    call "%loggingBatchPath%" "An Error occurred in Run_Through_Path_Sort_And_Search_Empty_Folders of '%BADOBatchPath%' in EmptyFolderDetection.bat of File '%inputPath%'."
    call "%loggingBatchPath%" "'Run_Through_Path_Sort_And_Search_Empty_Folders' terminates with error."
    exit /b 1
)

@REM Change to the input folder
cd "%inputPath%"

@REM Process all files in the input path
for /f "delims=" %%F in ('dir "%inputPath%" /a-d /b') do (
    call "%fileSortingBatchPath%" "%%F" "%destinationPathForSortedFiles%"

    @REM Check the success of FileSorting
    if "!errorlevel!" neq "0" (
        call "%loggingBatchPath%" "FileSorting failed on File: '%%F'."
        call "%loggingBatchPath%" "'Run_Through_Path_Sort_And_Search_Empty_Folders' terminates with error."
        exit /b 1
    )
)

@REM Process all subdirectories recursively, if necessary
for /d %%F in ("%inputPath%\*") do (
    @REM Check for EmptyFolders in inputPath
    call "%emptyFolderDetectionBatchPath%" "%%~F"

    @REM Check for recursion and start the Run_Through_Path_Sort_And_Search_Empty_Folders again
    if "%recursive%" equ "r"  (
        if "!errorlevel!" neq "0" (
            @REM Folder for recursive Run is not Empty
            call :Run_Through_Path_Sort_And_Search_Empty_Folders "%%~F"
        )
    )
)

@REM End the Run_Through_Path_Sort_And_Search_Empty_Folders subroutine
call "%loggingBatchPath%" "'%BADOBatchPath%' terminates with success."
exit /b 0

:Duplicate_Detection_BADO
call "%loggingBatchPath%" "Start 'Duplicate_Detection_BADO' in '%destinationPathForSortedFiles%'."
@REM Search for duplicates in all files in the destination folder
echo '%BADORunPath%' Duplicate Detection of '%destinationPathForSortedFiles%':>> "%invalidFilePath%"
for /f "delims=" %%F in ('dir "%destinationPathForSortedFiles%" /a-d /s /b') do (
    call "%duplicateDetectionBatchPath%" "%%F"
    if "!errorlevel!" neq "0" (
        call "%loggingBatchPath%" "Duplicate_Detection_BADO failed on File '%%F'."
        call "%loggingBatchPath%" "'Duplicate_Detection_BADO' terminates with error."
        exit /b 1
    )
)
call "%loggingBatchPath%" "'Duplicate_Detection_BADO' terminates with success."
exit /b 0

:Run_Through_DestinationPathForSortedFiles_And_Search_For_EmptyFolders
for /r "%destinationPathForSortedFiles%" /d %%F in (*) do (
    echo %%F
    call :Remove_Empty_Folder_With_UserChoice "%%F"
)
for /d %%F in ("%destinationPathForSortedFiles%\*") do (
    call :Remove_Empty_Folder_With_UserChoice "%%F"
) 
call "%loggingBatchPath%" "'Run_Through_DestinationPathForSortedFiles_And_Search_For_EmptyFolders' terminates with success."
exit /b 0

:Remove_Empty_Folder_With_UserChoice
@REM %1 = inputFolder
set "inputFolder=%~1"
call "%emptyFolderDetectionBatchPath%" "%inputFolder%"
if "!errorlevel!" equ "0" (
    call "%loggingBatchPath%" "'%inputFolder%' is Empty. This folder will be removed if you accept it."
    echo "%inputFolder%" is Empty. This folder will be removed if you accept it.
    set /p "userChoice=Do you want to remove '%inputFolder%'? Type 'y' for Yes, or 'n' for no."
    if /i "%userChoice%" equ "y" (
        rmdir "%inputFolder%"
        call "%loggingBatchPath%" "'%inputFolder%' is deleted."
        echo "%inputFolder%" is deleted. 
    ) else (
        call "%loggingBatchPath%" "'%inputFolder%' was not deleted."
        echo "%inputFolder%" was not deleted.
    )
    call "%loggingBatchPath%" "'Remove_Empty_Folder_With_UserChoice' terminates with success."
) else (
    call "%loggingBatchPath%" "'Remove_Empty_Folder_With_UserChoice' terminates with error."
)
exit /b 0

endlocal
