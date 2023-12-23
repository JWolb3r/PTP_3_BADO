import os
# DeleteFromBlacklist-Script Functionality:
# The script deletes the given folder path from the given blacklist file path, if the path is valid.

def deleteFromBlacklist(blacklistFilePath, blacklistInputPath):
    # Check if the specified path exists and is a directory
    if os.path.exists(blacklistInputPath) and os.path.isdir(blacklistInputPath):
        try:
            # Read all blacklistContent from the blacklistFile
            with open(blacklistFilePath, 'r') as blacklistFile:
                blacklistContent = blacklistFile.readlines()          
            # Remove the unwanted line
            filteredBlacklistContent = []
            for currentLine in blacklistContent:
                if blacklistInputPath not in currentLine:
                    filteredBlacklistContent.append(currentLine)
            # Write the updated blacklistContent back to the blacklistFile
            with open(blacklistFilePath, 'w') as blacklistFile:
                blacklistFile.writelines(filteredBlacklistContent)
            print(f"'{blacklistInputPath}' has been deleted from the Blacklist.")
        except Exception as e:
            print("Error while deleting the content from the Blacklist")
    else:
        print(f"The given Blacklist Path '{blacklistInputPath}' is invalid.")