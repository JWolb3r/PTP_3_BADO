# SearchInBlacklist-Script Functionality:
# The script searches for the provided input path in the given blacklist file path, after verifying its validity.

def seachInBlacklist(blacklistFilePath, searchedBlacklistPath):
    try:
        # Open the file in read mode
        with open(blacklistFilePath, 'r') as blacklistFile:
            for currentBlacklistLine in blacklistFile:
                # Check if the blacklistFilePath is in Blacklist
                if searchedBlacklistPath in currentBlacklistLine:
                    print("Path '{searchedBlacklistPath}' is on Blacklist.")
                    return 0

        print(f"Path '{searchedBlacklistPath}' is not on Blacklist.")
        return 1
    # Catches Generell Exceptions
    except Exception as e:
        print(f"Error while reading the Blacklist: {e}")
        return 1
