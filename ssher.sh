#!/bin/bash

add_command() {
	COMMANDS+=$(cat scripts/$1)
	SEND_COMMANDS=1
}

USER=$1
shift
IP=$1
shift

COMMANDS=""

while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do case $1 in
    -k | --keygen )
    ssh-keygen
    ;;
    -i | --copy-id )
    ssh-copy-id $USER@$IP
    ;;
	-d | --diagnostic )
	add_command get/diagnostic.sh
	;;
	-u | --users | --groups )
	add_command get/users.sh
	;;
	-b | --bashrc )
	add_command get/bashrc.sh
	;;
	-m | --modified )
	add_command get/modified.sh
	;;
	-q | --hushlogin )
	add_command set/hushlogin.sh
	;;
	-c | --copy )
	scp -r ./scripts/ $IP:
	;;
esac; shift; done
if [[ "$1" == "--" ]]; then shift; fi

#scp -r ./scripts/ $IP:
#ssh $IP "cd ~/scripts; ./run.sh; cd; rm -rf ~/client/"

if [[ -v SEND_COMMANDS ]]; then
	ssh $USER@$IP -qt <<< $COMMANDS
fi

