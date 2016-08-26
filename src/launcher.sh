#!/usr/bin/env bash

echo $XMODIFIERS >> trace.txt


handle_signal () {
	echo 'got siginal'
	echo 'launch gedit'
	gedit&

}

trap handle_signal SIGHUP

while true; do

        sleep 1

done

