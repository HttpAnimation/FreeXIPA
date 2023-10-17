#!/bin/bash

# Define the output .ipa file name
IPA_NAME="FreeXIPA.ipa"

# Ask the user for the path to the .xcarchive file
read -p "Please provide the path to the .xcarchive file: " XCARCHIVE_PATH

# Verify that the provided path exists
if [ ! -d "$XCARCHIVE_PATH" ]; then
  echo "Error: The provided directory does not exist."
  exit 1
fi

# Navigate to the .xcarchive file directory
cd "$XCARCHIVE_PATH" || exit 1

# Extract the .app files
unzip -q -o "Products/Applications/*.app"

# Create a Payload directory and move the .app file into it
mkdir -p "Payload"
mv *.app "Payload/"

# Create the .ipa file in the same directory as the .xcarchive
cd ..
zip -r "$IPA_NAME" "$XCARCHIVE_PATH/Payload"

# Clean up temporary files
rm -rf "$XCARCHIVE_PATH/Payload"
rm -rf "$XCARCHIVE_PATH/Applications"

echo "Created $IPA_NAME in the same directory as the .xcarchive."
