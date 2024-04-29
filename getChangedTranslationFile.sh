#!/bin/bash


SEARCH='strings.xml'
CHANGEDFILES=''
for file in $@; do
        if [[ "$file" == *"strings.xml" ]]; then
              echo "$file was changed"
              CHANGEDFILES="${CHANGEDFILES} $file"
        fi
done

echo "$CHANGEDFILES"
