#!/bin/sh
echo "--------------------"
echo "creating buildlist"
git diff --name-only HEAD~1 HEAD | while read file; do echo "$(git rev-parse --show-toplevel)/$file"; done > /tmp/buildList.txt
sed 's|/S0W1||g' /tmp/buildList.txt > /tmp/temp.txt && mv /tmp/temp.txt /tmp/buildList.txt  
