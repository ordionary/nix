#!/bin/bash

# Create secrets directory if it doesn't exist
mkdir -p secrets/plist

# Array of app IDs to export
APP_IDS=(
  "com.lwouis.alt-tab-macos"
  "com.jordanbaird.Ice"
  "com.apphousekitchen.aldente-pro.plist"
  "com.lihaoyun6.QuickRecorder.plist"
)

# Export each plist
for APP_ID in "${APP_IDS[@]}"; do
  echo "Exporting $APP_ID..."
  defaults export "$APP_ID" - >"secrets/plist/$APP_ID.plist"

  # Check if export was successful
  if [ $? -eq 0 ]; then
    echo "Successfully exported $APP_ID to secrets/$APP_ID.plist"
  else
    echo "Failed to export $APP_ID"
  fi
done

echo "All exports completed!"
