#!/bin/bash

if [ "$1" != "passwd" ]; then
    echo "Error: File name must be 'passwd'"
    exit 1
fi

echo "Home directory:"
awk -F: '{print $6}' "$1"

echo "Usernames:"
awk -F: '{print $1}' "$1"

echo "Number of users:"
awk -F: 'END {print NR}' "$1"

read -p "Enter username: " username
awk -F: -v user="$username" '$1 == user {print $6}' "$1"

echo "Users with UID range 1000-1010:"
awk -F: '$3 >= 1000 && $3 <= 1010 {print $1}' "$1"

echo "Users with standard shells:"
awk -F: '$7 == "/bin/bash" || $7 == "/bin/sh" {print $1}' "$1"

awk '{gsub("/", "\\\\"); print}' "$1" > new_passwd

hostname -I

curl -s ifconfig.me

su - john

echo "John's home directory:"
echo $HOME
