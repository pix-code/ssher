#!/bin/sh

indent() {
	sed 's/^/\t/'
}

echo -e "\nFLAG:"
cat ~/flag.txt | indent

echo -e "\nHOSTNAME:"
hostname | indent

echo -e "\nSERVICES:"
systemctl list-units --type=service --state=running --no-pager --quiet | sed 's/  //' | sed 's/loaded active running\|.service//g' | indent

echo -e "\nMODULES:"
ls -1 /lib/modules/$(uname -r)/kernel | indent

