@echo off
echo Start all Tests for BADOBatches.
call "%cd%\TestHelper.bat"
cd "%BADOBatchesTestFilesFolderPath%"
echo Start emptyFolderDetectionTest.bat
call "%emptyFolderDetectionTestBatchPath%"
echo Start FileSortingTest.bat
call "%fileSortingTestBatchPath%"
echo Start DuplicateDetectionTest.bat
call "%duplicateDetectionTestBatchPath%"
echo All created Files should be deleted.
rmdir /s "%BADOBatchesTestFilesFolderPath%"