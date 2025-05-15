#!/bin/sh
echo "--------------------"
echo "creating buildlist"
git -C /u/workspace/Development/Banking_Demo diff --name-only HEAD~1 HEAD | awk -v repo="/u/workspace/Development/Banking_Demo" '{print repo "/" $0}' > /u/workspace/buildList.txt
sed 's|/S0W1||g' /u/workspace/buildList.txt > /u/workspace/temp.txt && mv /u/workspace/temp.txt /u/workspace/buildList.txt  
