#!/bin/bash

# Create a temporary directory
TMPDIR=$(mktemp -d)

# Take a screenshot of a selected area and save it as screenshot.png in the temporary directory
gnome-screenshot -a -f $TMPDIR/screenshot.png

# Process the screenshot with Tesseract and save the result to a text file in the temporary directory
tesseract -l eng+jpn+ara $TMPDIR/screenshot.png $TMPDIR/output 

# Copy the result to the clipboard, preserving Unicode characters
cat $TMPDIR/output.txt | xclip -selection clipboard -in -target UTF8_STRING

echo "Text copied to clipboard. Temporary file: $TMPDIR/output.txt"

# Optionally, remove the temporary directory when done
rm -r $TMPDIR

