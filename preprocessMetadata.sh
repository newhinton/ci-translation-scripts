#!/bin/bash

for file in $@; do
        if [[ "$file" == "fastlane/metadata/android/**/.txt" ]]; then
		echo "$file was changed"
		cat "$file" >> generatedContent.txt
        fi
done
