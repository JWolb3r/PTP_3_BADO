@echo off
@REM General Setup Script Functionality:
@REM Creates environment variables for all scripts general used scripts.
@REM %1=BasePath, %2=DestinationPath for Information Files and Folders

@REM GeneralPaths
set "basePath=%~1"
set "destinationPathForInfomrmationFiles=%~2\InformationtxtFilesBADO"
set "operatingBatchesPath=%basePath%\OperatingBatches"
set "BADOBatchesFolderPath=%operatingBatchesPath%\BADOBatches"
set "blacklistOperationsFolderPath=%operatingBatchesPath%\BlacklistOperations"
set "generalBatchesPath=%operatingBatchesPath%\GeneralBatches"
set "internBatchSaveFilesPath=%basePath%\InternBatchSaveFilesPath"
set "consoleUIBatchPath=%basePath%\ConsoleUI.bat"

@REM OperatingBatches GeneralBatches Paths
set "isValidFolderPathBatchPath=%generalBatchesPath%\IsValidFolderPath.bat"
set "loggingBatchPath=%generalBatchesPath%\Logging.bat"
set "searchFolderBatchPath=%generalBatchesPath%\SearchFolder.bat"

@REM OperatingBatches BADOBatches Paths
set "BADOBatchPath=%BADOBatchesFolderPath%\BADO.bat"
set "BADOSetUpBatchPath=%BADOBatchesFolderPath%\BADOSetUp.bat"

@REM BlacklistOperations
set "searchInBlacklistBatchPath=%blacklistOperationsFolderPath%\SearchInBlacklist.bat"
set "deleteFromBlacklistBatchPath=%blacklistOperationsFolderPath%\DeleteFromBlacklist.bat"
set "addToBlacklistBatchPath=%blacklistOperationsFolderPath%\AddToBlacklist.bat"

@REM SearchFolder.bat Paths
set "foundedFoldersFilePath=%destinationPathForInfomrmationFiles%\foundedFolders.txt"

@REM Log File Path
set "loggingFolderPath=%destinationPathForInfomrmationFiles%\Logging-Files"
set "loggingFilePath=%loggingFolderPath%\Log(%date%).txt"

@REM SearchInBlacklist.bat Paths
set "blacklistFilePath=%internBatchSaveFilesPath%\Blacklist.txt"

if not exist "%loggingFolderPath%" mkdir "%loggingFolderPath%"
if not exist "%internBatchSaveFilesPath%" mkdir "%internBatchSaveFilesPath%"
if not exist "%blacklistFilePath%" echo "Start of Blacklist">> "%blacklistFilePath%"