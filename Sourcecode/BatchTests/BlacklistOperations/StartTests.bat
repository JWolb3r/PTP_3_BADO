@echo off
echo Start all Tests for GeneralBatches.
call "%cd%\TestHelper.bat"
echo Start AddToBlacklistTest.bat
call "%addToBlacklistTestBatchPath%"
echo Start DeleteFromBlacklistTest.bat
call "%deleteFromBlacklistTestBatchPath%"
echo Start SearchInBlacklistTest.bat
call "%searchInBlacklistTestBatchPath%"
echo Finished Tests for GeneralBatches

echo Alle erstellten TestFiles sollten gelöscht werden.
rmdir /s "%blacklistOperationsTestFilesFolderPath%"