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

# Navigate to the .xcarchive file and extract it
cd "$XCARCHIVE_PATH" || exit 1
unzip -q -o "Products/Applications/*.app"

# Create a Payload directory and move the .app file into it
mkdir -p "Payload"
mv *.app "Payload/"

# Create the .ipa file
zip -r "$IPA_NAME" "Payload"

# Clean up temporary files
rm -rf "Payload"
rm -rf "Applications"

echo "Created $IPA_NAME"
