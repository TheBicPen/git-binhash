#!/bin/bash
find .. -type f -name "*.md5sum" -exec md5sum --check {} \;
