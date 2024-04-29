#!/bin/bash

TARGET="generatedContent.txt"
touch "$TARGET"

for file in ${@:2}; do
    if [[ "$file" == "fastlane/metadata/android/"* ]]; then
        echo "$file was changed"
        cat "$file" >> "$TARGET"
	echo "\n" >> "$TARGET"
    fi
done
cat "$TARGET"

SEARCH='strings.xml'
CHANGEDFILES=''
for file in ${@:2}; do
        if [[ "$file" == *"strings.xml" ]]; then
              echo "$file was changed"
              CHANGEDFILES="${CHANGEDFILES} $file"
        fi
done

echo "$CHANGEDFILES"
echo "$1"

DIFF=$(git diff -U0 HEAD~$1 $CHANGEDFILES | grep -E "^\+" | grep -v +++ | cut -c 2- | sed 's/^[ \t]*\(.*$\)/\1/')
echo "$DIFF"
echo "<xml>$DIFF</xml>" | xmlstarlet sel -t -m '//string' -v . -n > changed_texts.txt
TRANSLATIONS=$(cat changed_texts.txt)
TRANSLATIONS="${TRANSLATIONS//'%'/' ; '}"
TRANSLATIONS="${TRANSLATIONS//$'\n'/' ; '}"
TRANSLATIONS="${TRANSLATIONS//$'\r'/' ; '}"
echo "$TRANSLATIONS"
echo "$TRANSLATIONS" >> "$TARGET"
