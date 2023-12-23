@echo off
@REM Logging-Script Functionality:
@REM Logs the provided information into the logging file using a configured format.
@REM %1 = Logging info
@REM Append the logging information with the current date and time to the specified logging file
echo [%date%, %time%]:%~1>> "%loggingFilePath%"

exit /b 0
