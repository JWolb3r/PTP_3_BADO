@echo off
echo Start all Tests for GeneralBatches.
call "%cd%\TestHelper.bat"
echo Start LoggingTest.bat
call "%loggingTestBatchPath%"
echo Start SearchFolderTest.bat
call "%searchFolderTestBatchPath%"
echo Start IsValidFolderTest.bat
call "%isValidFolderPathTestBatchPath%"
echo Finished Tests for GeneralBatches

echo All created Files should be deleted.
rmdir /s "%generalBatchesTestFilesFolderPath%"