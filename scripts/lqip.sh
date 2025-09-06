#!/usr/bin/env bash

# Check if image argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <image>"
  exit 1
fi

INPUT="$1"

# Create a small blurred version
TMP_FILE=$(mktemp /tmp/lqip.XXXXXX.jpg)
convert "$INPUT" -resize 20x -blur 0x8 "$TMP_FILE"

# Echo base64 data URL
echo -n "data:image/jpeg;base64,"
base64 -w 0 "$TMP_FILE"
echo

# Clean up
rm "$TMP_FILE"

