@echo off
setlocal enabledelayedexpansion
set "basePath=%cd%"
echo %basePath%

echo Welcome to the BADO UI.

:User_Choice_Information_Folder_Method
@REM Get the path where txt files for found folders and log files will be created.
echo Enter the path where txt files for found folders from SearchedFolder.bat and log files will be created.
set /p "pathForInformationFiles="
call :Init_Method "%pathForInformationFiles%"
if "!errorlevel!" neq "0" (
    echo The specified folder is invalid.
    goto :User_Choice_Information_Folder_Method
)

@REM Menu to choose BADO, Search Folder, or Exit.
setlocal
echo Starting the User_Interaction_Method.
:User_Interaction_Method
echo.
echo ============================
echo   BADO UI - Main Menu
echo ============================
echo 1. Start BADO
echo 2. Search Folder
echo 3. Add to Blacklist
echo 4. Delete from Blacklist
echo 5. Search in Blacklist
echo 6. Exit
echo ============================
echo Enter the number of your choice:
set /p "userChoice="

if /i "!userChoice!" equ "1" (
    call :BADO_Method
) else if /i "!userChoice!" equ "2" (
    call :Search_Folder_Method
) else if /i "!userChoice!" equ "3" (
    call :Add_to_Blacklist_Method
) else if /i "!userChoice!" equ "4" (
    call :Delete_from_Blacklist_Method
) else if /i "!userChoice!" equ "5" (
    call :Search_in_Blacklist_Method
) else if /i "!userChoice!" equ "6" (
    echo You entered 'Exit'. BADO UI terminates.
    exit /b
) else (
    echo Invalid input. Please enter a number between 1 and 6.
    goto :User_Interaction_Method
)
goto :User_Interaction_Method
endlocal

@REM Function to initialize path variables.
:Init_Method 
@REM %1=pathForInformationFiles
echo Initialization of the BADO ConsoleUI started.
set "inputPath="
@REM Test path manually because BatchPaths environment vars are not initialized.
if exist "%~1%" (
    if "%~x1" equ "" (
        echo Your given path is valid. 
        echo Initialization successfully completed.
        @REM If the input path is empty and exists, execute GeneralSetUp.bat.
        call "%basePath%\OperatingBatches\GeneralBatches\GeneralSetUp.bat" "%basePath%" "%~1"
        exit /b 0
    )
) 
exit /b 1

@REM Function for BADO operations, new local Field for Subroutine var.
setlocal
:BADO_Method
call "%loggingBatchPath%" "Start 'BADO_Method'."
echo You have started BADO.
echo Enter the path of the folder that BADO should process or type 'exit' to return to the main menu.
set /p "inputPath="
if /i "!inputPath!" equ "exit" (
    echo Exiting BADO.
    exit /b 0
)
echo If BADO should run recursively through all subdirectories in the target folder, enter 'r' in the console else press 'Enter'.
set /p "recursive="
echo Enter the file path where BADO should write its results.
set /p "destinationPathForBADOSortedAndDuplicateFiles="

call "%BADOBatchPath%" "%inputPath%" "%destinationPathForBADOSortedAndDuplicateFiles%" "%recursive%"
call :Errorlevel_Check_Console_Output_And_Logging_Method "BADO_Method" "" ""
exit /b 0
endlocal

setlocal enabledelayedexpansion
@REM Function for searching folders.
:Search_Folder_Method
call "%loggingBatchPath%" "Start 'Search_Folder_Method'."
echo Enter the name of the folder to search for or type 'exit' to return to the main menu.
set /p "searchedFolder="
if /i "!searchedFolder!" equ "exit" (
    echo Exiting Search Folder.
    exit /b 0
)
echo Specify the file path or drive to search in.
echo Please note that the algorithm takes longer to search in larger paths.
set /p "pathToSearchIn="
call "%searchFolderBatchPath%" "%pathToSearchIn%" "%searchedFolder%"
call :Errorlevel_Check_Console_Output_And_Logging_Method "Search_Folder_Method" "No folder with the name '%searchedFolder%' could be found in the given file path '%pathToSearchIn%'." "The results after searching for the folder '%searchedFolder%' are listed in '%foundedFoldersFilePath%'."
exit /b 0
endlocal

setlocal enabledelayedexpansion
:Add_to_Blacklist_Method
call "%loggingBatchPath%" "Start 'Add_To_Blacklist_Method' in '%consoleUIBatchPath%'."
echo Enter the filepath you want to add to the Blacklist. If you don't know the filepath, search for it using the 'Search Folder' function. Type 'exit' to return to the main menu.
set /p "userInputBlacklistPath="
if /i "!userInputBlacklistPath!" equ "exit" (
    echo Exiting Add to Blacklist.
    exit /b 0
)
call "%addToBlacklistBatchPath%" "%userInputBlacklistPath%"
call :Errorlevel_Check_Console_Output_And_Logging_Method "Add_to_Blacklist_Method" "" ""
exit /b 0
endlocal

setlocal enabledelayedexpansion
:Delete_from_Blacklist_Method
@REM %1 = Input Blacklist Path
call "%loggingBatchPath%" "Start Delete_from_Blacklist_Method in '%consoleUIBatchPath%'."
echo Which file do you want to delete from the Blacklist? Enter the filepath. If you don't know the filepath, search for it using the 'Search Folder' function. Type 'exit' to return to the main menu.
set /p "userInputBlacklistPath="
if /i "!userInputBlacklistPath!" equ "exit" (
    echo Exiting Delete from Blacklist.
    exit /b 0
)
echo If you want to inspect the file before deleting it, check the path '%blacklistFilePath%'.
call "%deleteFromBlacklistBatchPath%" "%userInputBlacklistPath%"
call :Errorlevel_Check_Console_Output_And_Logging_Method "Delete_from_Blacklist_Method" "" ""
exit /b 0
endlocal

setlocal enabledelayedexpansion
:Search_in_Blacklist_Method
call "%loggingBatchPath%" "Start Search_in_Blacklist_Method in '%consoleUIBatchPath%'."
echo Enter the path you want to search in the Blacklist or type 'exit' to return to the main menu.
set /p "userInputBlacklistPath="
if /i "!userInputBlacklistPath!" equ "exit" (
    echo Exiting Search in Blacklist.
    exit /b 0
)
call "%searchInBlacklistBatchPath%" "%userInputBlacklistPath%"
call :Errorlevel_Check_Console_Output_And_Logging_Method "Search_in_Blacklist_Method" "No folder with the name '%userInputBlacklistPath%' could be found in the given file path." "The folder '%userInputBlacklistPath%' is already on the Blacklist."
exit /b 0
endlocal

setlocal
:Errorlevel_Check_Console_Output_And_Logging_Method
@REM %1 = MethodName, %2 = additional Error Log Text, %3 = additional Success Log Text
set "methodName=%~1"
set "additionalErrorLogText=%~2"
set "additionalSuccessLogText=%~3"
if "!errorlevel!" neq "0" (
    call "%loggingBatchPath%" "An error occurred in '%methodName%' in '%consoleUIBatchPath%'. Look for details in '%loggingFilePath%'."
    call "%loggingBatchPath%" "'%methodName%' in '%consoleUIBatchPath%' terminates with error."
    if "%additionalErrorLogText%" neq "" (
        call "%loggingBatchPath%" "%additionalErrorLogText%"
        echo "%additionalErrorLogText%"
    )
    echo An error occurred in '%methodName%' in '%consoleUIBatchPath%'. Look for details in '%loggingFolderPath%'.
    echo '%methodName%' in '%consoleUIBatchPath%' terminates with error.
    exit /b 1
) else (
    if "%additionalSuccessLogText%" neq "" (
        call "%loggingBatchPath%" "%additionalSuccessLogText%"
        echo "%additionalSuccessLogText%"
    )
    call "%loggingBatchPath%" "'%methodName%' in '%consoleUIBatchPath%' terminates with success."
    echo '%methodName%' in '%consoleUIBatchPath%' terminates with success.
    exit /b 0
)
exit /b 0 
endlocal

endlocal