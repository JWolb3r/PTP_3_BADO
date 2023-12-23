@echo off
REM Set paths for batch tests
set "batchTestsPath=%cd%"
set "BADOBatchesTestFilesFolderPath=%batchTestsPath%\BADOBatchesTestFiles"

cd ..
cd ..

REM Set paths for BADO Batches, General Batches, and Blacklist Operations
set "BADOBatchesPath=%cd%\OperatingBatches\BADOBatches"
set "generalBatchesPath=%cd%\OperatingBatches\GeneralBatches"
set "blacklistOperationsPath=%cd%\OperatingBatches\BlacklistOperations"

REM Set up valid and invalid Cases
set "emptyFolderPath=%BADOBatchesTestFilesFolderPath%\EmptyTestFolder"
set "folderWithFiles=%BADOBatchesTestFilesFolderPath%"

REM Set Up Batch Test Paths
set "emptyFolderDetectionTestBatchPath=%batchTestsPath%\EmptyFolderDetectionTest.bat"
set "fileSortingTestBatchPath=%batchTestsPath%\FileSortingTest.bat"
set "duplicateDetectionTestBatchPath=%batchTestsPath%\DuplicateDetectionTest.bat"

REM Set up Batch Paths
set "fileSortingBatchPath=%BADOBatchesPath%\FileSorting.bat"
set "emptyFolderDetectionBatchPath=%BADOBatchesPath%\EmptyFolderDetection.bat"
set "duplicateDetectionBatchPath=%BADOBatchesPath%\DuplicateDetection.bat"
set "loggingBatchPath=%generalBatchesPath%\Logging.bat"
set "isValidFolderPathBatchPath=%generalBatchesPath%\IsValidFolderPath.bat"

REM Set up txt Files and Folders for Tests
set "loggingFilePath=%BADOBatchesTestFilesFolderPath%\TestLoggingFile.txt"
set "hashFilePath=%BADOBatchesTestFilesFolderPath%\TestHashfile.txt"
set "dummyFilePath=%BADOBatchesTestFilesFolderPath%\Dummy.txt"
set "dummyFileName=Dummy.txt"
set "sortedDummyFilesPath=%BADOBatchesTestFilesFolderPath%\SortedDummyFiles"
set "dummyExtensionFolderPath=%sortedDummyFilesPath%\txt-Folder"
set "dummyCloneFolderPath=%dummyExtensionFolderPath%\Dummy-Files"
set "emptyFolderFilePath=%BADOBatchesTestFilesFolderPath%\TestEmptyFoundFolders.txt"
set "destinationPathForDuplicateFiles=%BADOBatchesTestFilesFolderPath%\TestDuplicateFolder"
set "invalidFilePath=%BADOBatchesTestFilesFolderPath%\TestInvalidFile.txt"

REM Create necessary folders if they don't exist
if not exist "%sortedDummyFilesPath%" mkdir "%sortedDummyFilesPath%"
if not exist "%emptyFolderPath%" mkdir "%emptyFolderPath%"
if not exist "%destinationPathForDuplicateFiles%" mkdir "%destinationPathForDuplicateFiles%"
