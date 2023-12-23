@echo off
@REM BADOSetUp-Script:
@REM The script creates the necessary environment variables for all scripts used in BADO.
@REM Sets up environment variables for all called BADOBatches
@REM %1=destinationPath

@REM GeneralPaths for BADOBatches
set "BADORunPath=%~1\BADO_Run_[%date%]"
set "destinationPathForSortedFiles=%BADORunPath%\SortedFiles"
set "destinationPathForDuplicateFiles=%BADORunPath%\DuplicateFiles"

@REM OperatingBatches BADOBatches Paths
set "duplicateDetectionBatchPath=%BADOBatchesFolderPath%\DuplicateDetection.bat"
set "emptyFolderDetectionBatchPath=%BADOBatchesFolderPath%\EmptyFolderDetection.bat"
set "fileSortingBatchPath=%BADOBatchesFolderPath%\FileSorting.bat"

@REM InformationFilesPath
set "informationFilesPath=%BADORunPath%\InformationFilesPath"

@REM DuplicateDetection.bat Paths
set "hashFilePath=%internBatchSaveFilesPath%\hash.txt"
set "invalidFilePath=%informationFilesPath%\invalidFiles.txt"

@REM EmptyFolderDetection.bat Paths
set "emptyFolderFilePath=%informationFilesPath%\EmptyFolders.txt"

if not exist "%informationFilesPath%" mkdir "%informationFilesPath%"