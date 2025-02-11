#!/bin/sh
echo "--------------------"
echo "creating buildlist"
git -C /tmp/appWorkspace/Development/MortgageApplication diff --name-only HEAD~1 HEAD | awk -v repo="/tmp/appWorkspace/Development/MortgageApplication" '{print repo "/" $0}' > /tmp/buildList.txt
sed 's|/S0W1||g' /tmp/buildList.txt > /tmp/temp.txt && mv /tmp/temp.txt /tmp/buildList.txt  
