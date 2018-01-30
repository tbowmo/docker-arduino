#!/bin/bash
echo "+-----------------------------------------------"
echo "|Building       - $1"
echo "|With board def - $2"
echo "+-----------------------------------------------"

exec $*
#exec arduino "$1" --verify --board "$2"

