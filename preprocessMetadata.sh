#!/bin/bash

for file in $@; do
    if [[ "$file" == "fastlane/metadata/android/"* ]]; then
        echo "$file was changed"
        cat "$file" >> generatedContent.txt
    fi
done
