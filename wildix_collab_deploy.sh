#!/bin/bash

# Path to the folder
FOLDER_PATH=~/Library/Application\ Support/Wildix\ Collaboration/storage

# If the folder does not exist, create it
if [ ! -d "$FOLDER_PATH" ]; then
    echo "The folder '$FOLDER_PATH' does not exist. Creating folder..."
    mkdir -p "$FOLDER_PATH"
else
    echo "The folder '$FOLDER_PATH' exists."
fi

# Change directory to the folder
cd "$FOLDER_PATH"

# Move to the parent directory
cd ..

# Path to the settings.json file in the storage folder
SETTINGS_FILE="storage/settings.json"
CHANGED=false  # Flag to track if settings.json was changed

# Check if the settings.json file exists
if [ -f "$SETTINGS_FILE" ]; then
    echo "The file 'settings.json' exists."

    # Check if the file contains the specific string
    STRING_TO_SEARCH="yourwildixinstance.wildixin.com"
    if grep -q "$STRING_TO_SEARCH" "$SETTINGS_FILE"; then
        echo "The string '$STRING_TO_SEARCH' is present in the file."
    else
        echo "The string '$STRING_TO_SEARCH' is not present in the file. Adding content..."

        # Content to be written into settings.json
        NEW_CONTENT='{"host":"yourwildixinstance.wildixin.com","callControlMode":false,"callBringToFrontMode":true,"allowInsecureConnections":false,"keepRunningOnClose":true,"launchAtStartup":true}'

        # Write the new content into the file
        echo "$NEW_CONTENT" > "$SETTINGS_FILE"
        echo "The file 'settings.json' has been updated."
        CHANGED=true  # Set the flag to indicate changes were made

        # Delete lastWindowStatesettings.json and failover.json in the storage folder
        LAST_WINDOW_STATE="storage/lastWindowStatesettings.json"
        FAILOVER="storage/failover.json"

        if [ -f "$LAST_WINDOW_STATE" ]; then
            echo "Deleting '$LAST_WINDOW_STATE'..."
            rm "$LAST_WINDOW_STATE"
        fi

        if [ -f "$FAILOVER" ]; then
            echo "Deleting '$FAILOVER'..."
            rm "$FAILOVER"
        fi

        # Delete all files and folders in the parent directory except the storage folder
        echo "Deleting all files and folders in $(pwd), except for the 'storage' folder..."
        find . -mindepth 1 -maxdepth 1 ! -name 'storage' -exec rm -rf {} +
        echo "Deletion completed."

        # Move up one more directory
        cd ..

        # Check if the com.wildix.wiservice folder exists and delete its content
        WISERVICE_FOLDER="com.wildix.wiservice"
        if [ -d "$WISERVICE_FOLDER" ]; then
            echo "The folder '$WISERVICE_FOLDER' exists. Deleting all content..."
            rm -rf "$WISERVICE_FOLDER"/*
            echo "Content of '$WISERVICE_FOLDER' has been deleted."
        else
            echo "The folder '$WISERVICE_FOLDER' does not exist."
        fi
    fi
else
    echo "The file 'settings.json' does not exist. Creating and filling it..."

    # Content to be written into settings.json
    CONTENT='{"host":"yourwildixinstance.wildixin.com","callControlMode":false,"callBringToFrontMode":true,"allowInsecureConnections":false,"keepRunningOnClose":true,"launchAtStartup":true}'

    # Create a new file and add content
    echo "$CONTENT" > "$SETTINGS_FILE"
    echo "The file 'settings.json' has been created and filled."
    CHANGED=true  # Set the flag to indicate a new file was created
fi

# App check for Wildix Collaboration
APP1="/Applications/Wildix Collaboration.app"

# If settings.json was changed, terminate and restart Wildix Collaboration if it's installed
if $CHANGED; then
    # Check if the first app exists before terminating and restarting
    if [ -d "$APP1" ]; then
        echo "The app 'Wildix Collaboration' is installed. Terminating and restarting it..."
        pkill -f "Wildix"  # Terminate the Wildix process
        sleep 10  # Wait for 10 seconds
        open "$APP1"  # Start Wildix Collaboration.app
        echo "Wildix Collaboration.app has been restarted."
    else
        echo "The app 'Wildix Collaboration' is not installed. Skipping termination and restart."
    fi

    # Terminate the Wildix Integration Service (it will restart automatically)
    echo "Terminating the Wildix Integration Service..."
    pkill -f "Wildix Integration Service"
else
    echo "No changes were made to settings.json. Skipping application termination and restart."
fi

echo "Done."
