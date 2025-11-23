INPUT="$1"

# Create a temp file
TMP_FILE=$(mktemp /tmp/lqip.XXXXXX.jpg)

# OPTIMIZATION EXPLANATION:
# -resize 20x: Keeps it tiny.
# -blur 0x8: Applies the blur effect.
# -strip: REMOVES all metadata (EXIF, ICC profiles, comments). This is crucial.
# -quality 30: Lowers JPEG quality. Since it's blurred, artifacts are invisible.
# -interlace Plane: efficient progressive encoding.
# -define jpeg:sampling-factor=4:2:0: Reduces color resolution (human eye won't notice on a blurred image).
# -colorspace sRGB: Ensures compatibility and removes bulky color profiles.

convert "$INPUT" \
  -resize 20x \
  -blur 0x8 \
  -strip \
  -quality 30 \
  -interlace Plane \
  -define jpeg:sampling-factor=4:2:0 \
  -colorspace sRGB \
  "$TMP_FILE"

# Echo base64 data URL
echo -n "data:image/jpeg;base64,"
base64 -w 0 "$TMP_FILE"
echo

# Clean up
rm "$TMP_FILE"
