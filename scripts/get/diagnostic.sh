#!/bin/sh

echo -e "\nFLAG:"
cat ~/flag.txt | sed 's/^/\t/'

echo -e "\nHOSTNAME:"
hostname | sed 's/^/\t/'

echo -e "\nSERVICES:"
systemctl list-units --type=service --state=running --no-pager --quiet | sed 's/  //' | sed 's/loaded active running\|.service//g' | sed 's/^/\t/'

echo -e "\nMODULES:"
ls -1 /lib/modules/$(uname -r)/kernel | sed 's/^/\t/'

