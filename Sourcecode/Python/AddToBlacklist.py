import os
from SearchInBlacklist import searchInBlacklist
# AddToBlacklist-Script Functionality:
# The script accepts a folder path and the blacklist file path as input and adds it to the blacklist if the folder path is valid and not already on the blacklist.

def addToBlacklist(blacklistFilePath, blacklistInputPath):
    # Check if the specified path exists and is a directory
    if os.path.exists(blacklistInputPath) and os.path.isdir(blacklistInputPath):
        try:
            # Check if the path is already on the Blacklist
            if searchInBlacklist(blacklistFilePath, blacklistInputPath) == 0:
                print(f"The given path '{blacklistInputPath}' is already on the Blacklist.")
                # End Method
                return

            # Open the blacklistFile in append mode
            with open(blacklistFilePath, 'a') as blacklistFile:
                blacklistFile.write(blacklistInputPath + '\n')
            
            print(f"'{blacklistInputPath}' has been added to Blacklist.")
        except Exception as e:
            print("Error while adding content to the Blacklist.")
    else:
        print(f"The given Blacklist Input Path '{blacklistInputPath}' is invalid.")

        