#!/bin/bash
find .. -type f ! -wholename '../.git/*' -print0 |
    git check-ignore -z --stdin |
    xargs -0 -P 0 -I FILE bash -c '
        mtime="$(stat -c %Y "FILE")"
        curhash="FILE.$mtime.md5sum"
        if [[ -f "$curhash" ]]; then
            exit 0
        fi
        filedir="$(dirname "FILE")"
        filebase="$(basename "FILE")"
        find "$filedir" -maxdepth 1 -type f -name "$filebase.*.md5sum" -exec rm -v {} \;
        md5sum "FILE" > "$curhash"
    '


