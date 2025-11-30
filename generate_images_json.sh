#!/bin/bash
IMAGE_DIR="./image"

OUTPUT_FILE="images.json"
FILES=$(find "$IMAGE_DIR" -maxdepth 1 -type f | grep -Ei '\.(jpg|jpeg|png|gif|bmp|tif|tiff|webp|svg|heif|heic|avif|ico|raw|cr2|nef|arw|dng)$')

TOTAL=$(echo "$FILES" | wc -l)

echo "[" > "$OUTPUT_FILE"
INDEX=0
while read -r FILE; do
  BASENAME=$(basename "$FILE")
  INDEX=$((INDEX + 1))
  if [ "$INDEX" -lt "$TOTAL" ]; then
    echo "  \"${BASENAME}\"," >> "$OUTPUT_FILE"
  else
    echo "  \"${BASENAME}\"" >> "$OUTPUT_FILE"
  fi
done <<< "$FILES"

echo "]" >> "$OUTPUT_FILE"
echo "Saved ${INDEX} image filenames to $OUTPUT_FILE"
