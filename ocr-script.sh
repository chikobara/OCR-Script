#!/bin/bash

# Create a temporary directory
TMPDIR=$(mktemp -d)

# Take a screenshot of a selected area and save it as screenshot.png in the temporary directory
gnome-screenshot -a -f $TMPDIR/screenshot.png

# Process the screenshot with Tesseract and save the result to a text file in the temporary directory
tesseract -l eng+jpn+ara $TMPDIR/screenshot.png $TMPDIR/output 

# Post-process the output to remove unnecessary spaces between Japanese characters
sed -i 's/\([一-龥ぁ-ゔァ-ヴー々〆〤]\) \+/\1/g' $TMPDIR/output.txt
sed -i 's/\([ぁ-ゔァ-ヴー々〆〤]\) \([ぁ-ゔァ-ヴー々〆〤]\)/\1\2/g' $TMPDIR/output.txt

# Copy the result to the clipboard, preserving Unicode characters
cat $TMPDIR/output.txt | xclip -selection clipboard -in -target UTF8_STRING

echo "Text copied to clipboard. Temporary file: $TMPDIR/output.txt"

# Optionally, remove the temporary directory when done
rm -r $TMPDIR
