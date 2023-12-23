@echo off
REM Set paths for batch tests
set "batchTestsPath=%cd%"
set "blacklistOperationsTestFilesFolderPath=%batchTestsPath%\BlacklistOperationsTestFiles"

cd ..
cd ..

REM Set paths for Blacklist Operations and General Batches
set "blacklistOperationsPath=%cd%\OperatingBatches\BlacklistOperations"
set "generalBatchesPath=%cd%\OperatingBatches\GeneralBatches"

REM Set up valid and invalid Cases
set "validBlacklistInput=%blacklistOperationsTestFilesFolderPath%"
set "invalidBlacklistInput=%generalBatchesTestFilesFolderPath%\IamInvalid"
set "isOnBlacklist=%batchTestsPath%"
set "isNotInBlacklist=%batchTestsPath%\BlacklistOperationsTestFiles"

REM Set Up Batch Test Paths
set "addToBlacklistTestBatchPath=%batchTestsPath%\AddToBlacklistTest.bat"
set "deleteFromBlacklistTestBatchPath=%batchTestsPath%\DeleteFromBlacklistTest.bat"
set "searchInBlacklistTestBatchPath=%batchTestsPath%\SearchInBlacklistTest.bat"

REM Set up Batch Paths
set "addToBlacklistBatchPath=%blacklistOperationsPath%\AddToBlacklist.bat"
set "deleteFromBlacklistBatchPath=%blacklistOperationsPath%\DeleteFromBlacklist.bat"
set "searchInBlacklistBatchPath=%blacklistOperationsPath%\SearchInBlacklist.bat"
set "loggingBatchPath=%generalBatchesPath%\Logging.bat"
set "isValidFolderPathBatchPath=%generalBatchesPath%\IsValidFolderPath.bat"

REM Set up txt Files for Tests
set "blacklistFilePath=%blacklistOperationsTestFilesFolderPath%\TestBlacklist.txt"
set "loggingFilePath=%blacklistOperationsTestFilesFolderPath%\TestLoggingFile.txt"

REM Create necessary folders if they don't exist
if not exist "%blacklistOperationsTestFilesFolderPath%" mkdir "%blacklistOperationsTestFilesFolderPath%"
if not exist "%blacklistFilePath%" echo "%isOnBlacklist%">> "%blacklistFilePath%"
