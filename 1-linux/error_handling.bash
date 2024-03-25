#!/bin/bash

check_privileges() {
    if [[ $EUID -ne 0 ]]; then
        echo "This script must be run with root privileges."
        exit 1
    fi
}

print_home_directory() {
    echo "Home directory: $(getent passwd | grep '^root:' | cut -d: -f6)"
}

list_usernames() {
    echo "Usernames:"
    getent passwd | cut -d: -f1
}

count_users() {
    echo "Number of users: $(getent passwd | wc -l)"
}

find_user_home() {
    read -p "Enter username to find home directory: " username
    user_home=$(getent passwd "$username" | cut -d: -f6)
    echo "Home directory of $username: $user_home"
}

list_users_uid_range() {
    echo "Users with UID range 1000-1010:"
    getent passwd | awk -F: '$3 >= 1000 && $3 <= 1010 {print $1}'
}

find_users_standard_shells() {
    echo "Users with standard shells (/bin/bash or /bin/sh):"
    getent passwd | awk -F: '$NF ~ "/bin/(ba)?sh$" {print $1}'
}

replace_chars_in_passwd() {
    sed 's/\//\\/g' /etc/passwd > /tmp/new_passwd_file
    echo "Content of /etc/passwd file with '/' replaced with '\' has been saved to /tmp/new_passwd_file"
}

print_private_ip() {
    private_ip=$(hostname -I)
    echo "Private IP: $private_ip"
}

print_public_ip() {
    public_ip=$(curl -s ifconfig.me)
    echo "Public IP: $public_ip"
}

switch_to_john_user() {
    su - john -c 'echo "Switched to john user. Current directory: $HOME"'
}

print_john_home_directory() {
    echo "Home directory of john user: $(getent passwd john | cut -d: -f6)"
}

check_privileges
print_home_directory
list_usernames
count_users
find_user_home
list_users_uid_range
find_users_standard_shells
replace_chars_in_passwd
print_private_ip
print_public_ip
switch_to_john_user
print_john_home_directory

exit 0
