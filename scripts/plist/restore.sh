#!/bin/bash

# Path to the plist directory
PLIST_DIR="secrets/plist"

# Check if the plist directory exists
if [ ! -d "$PLIST_DIR" ]; then
  echo "Error: Directory $PLIST_DIR does not exist."
  exit 1
fi

# Get all plist files in the directory
PLIST_FILES=("$PLIST_DIR"/*.plist)

# Check if there are any plist files
if [ ${#PLIST_FILES[@]} -eq 0 ] || [ "${PLIST_FILES[0]}" = "$PLIST_DIR/*.plist" ]; then
  echo "No plist files found in $PLIST_DIR."
  exit 1
fi

# Import each plist
for PLIST_PATH in "${PLIST_FILES[@]}"; do
  # Extract app ID from filename (remove path and .plist extension)
  FILENAME=$(basename "$PLIST_PATH")
  APP_ID="${FILENAME%.plist}"

  echo "Importing $APP_ID..."
  cat "$PLIST_PATH" | defaults import "$APP_ID" -

  # Check if import was successful
  if [ $? -eq 0 ]; then
    echo "Successfully imported $APP_ID from $PLIST_PATH"
  else
    echo "Failed to import $APP_ID"
  fi
done

echo "All imports completed!"
