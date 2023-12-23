@echo off
setlocal enabledelayedexpansion
@REM Duplicate Detection Script Functionality:
@REM This script takes an input file and generates its hash.
@REM The script verifies whether the file is a duplicate, or if it is potentially invalid.
@REM %1 = file
set "inputFile=%~1"
set "inputFilePath=%~dpnx1"

call "%loggingBatchPath%" "Start '%duplicateDetectionBatchPath%' with Input File: '%inputFile%'."

@REM Use certutil to hash the file and extract the SHA512 hash
for /f "tokens=1,4" %%a in ('certutil -hashfile "%inputFile%" SHA512') do (
    @REM Check if CertUtil encountered an error while hashing
    if "%%a" equ "CertUtil:" (
        if "%%b" equ "fehlgeschlagen:" (
            @REM Log an error if hashing failed and write the file path to the invalid file path
            call "%loggingBatchPath%" "Hashing of '%inputFile%' failed. File path has been written to '%invalidFilePath%'." 
            echo "Hashing of '%inputFile%' failed. Path of File:" >> "%invalidFilePath%" 
            echo "%inputFilePath%" >> "%invalidFilePath%"
        )
    ) else if "%%a" neq "CertUtil:" (
        @REM Check if the current token is not the header and is the SHA512 hash
        if "%%a" neq "SHA512-Hash" (
            if exist "%hashFilePath%" (
                @REM Search for hash of File in Hashfile.txt
                call :Search_For_Duplicate "%%a" "%inputFile%"
                if "!errorlevel!" equ "0" (
                    @REM If the hash is not found, write the hash and file path to the hash file
                    call %loggingBatchPath% "Write Hash of '%inputFilePath%' to '%hashFilePath%'."
                    echo "%inputFilePath%";"%%a">> %hashFilePath%
                )
            ) else (
                @REM If the hash file doesn't exist, create it and write the hash and file path
                call "%loggingBatchPath%" "Write Hash of '%inputFilePath%' to '%hashFilePath%'."
                echo "%inputFilePath%";"%%a">> %hashFilePath%
            ) 
        ) 
    )  
)

call "%loggingBatchPath%" "'%duplicateDetectionBatchPath%' terminates with success."
exit /b 0

:Search_For_Duplicate
@REM %1=hash, %2=inputFile
@REM Function to search for duplicate hashes in the hash file
if exist "%hashFilePath%" (
    for /f "usebackq tokens=1,2 delims=;" %%a in ("%hashFilePath%") do (
        @REM Compare the provided hash with existing hashes
        if "%~1" equ "%%~b" (
            @REM If a duplicate is found, log the information and move the file to the duplicate folder
            call "%loggingBatchPath%" "Duplicate file detected. Moving '!inputFile!' to '%destinationPathForDuplicateFiles%'."
            set "duplicateFolderPath=%destinationPathForDuplicateFiles%\%%~na-Folder"
            if not exist "!duplicateFolderPath!" mkdir "!duplicateFolderPath!"
            call "%fileSortingBatchPath%" "%~2" "!duplicateFolderPath!"
            exit /b 1
        )
    )
)
@REM If no duplicate is found, exit with success
exit /b 0
endlocal
