@echo off
REM Set paths for batch tests
set "batchTestsPath=%cd%"
set "generalBatchesTestFilesFolderPath=%batchTestsPath%\GeneralBatchesTestFiles"

cd ..
cd ..

REM Set paths for General Batches
set "generalBatchesPath=%cd%\OperatingBatches\GeneralBatches"

REM Set up valid and invalid Cases
set "validFolderCase=%generalBatchesTestFilesFolderPath%"
set "invalidFolderCase=%generalBatchesTestFilesFolderPath%\IamInvalid"

REM Set up Batch Paths
set "isValidFolderPathBatchPath=%generalBatchesPath%\IsValidFolderPath.bat"
set "searchFolderBatchPath=%generalBatchesPath%\SearchFolder.bat"
set "loggingBatchPath=%generalBatchesPath%\Logging.bat"

REM Set up Test Batch Paths
set "isValidFolderPathTestBatchPath=%batchTestsPath%\IsValidFolderPathTest.bat"
set "searchFolderTestBatchPath=%batchTestsPath%\SearchFolderTest.bat"
set "loggingTestBatchPath=%batchTestsPath%\LoggingTest.bat"

REM Set up txt Files for Tests
set "loggingFilePath=%generalBatchesTestFilesFolderPath%\TestLoggingFile.txt"
set "foundedFoldersFilePath=%generalBatchesTestFilesFolderPath%\TestFoundedFolders.txt"

REM Create necessary folders if they don't exist
if not exist "%generalBatchesTestFilesFolderPath%" mkdir "%generalBatchesTestFilesFolderPath%"
