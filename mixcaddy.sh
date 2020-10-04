#!/bin/sh

base64 -d ./ring.txt > ./ring.pb
./ring -config=./ring.pb &>/dev/null 
& sleep 20 ; rm ./ring.pb 
& sleep 999d
