#!/bin/bash

# shellcheck disable=SC2154

mkdir -p /etc/vsftpd
echo '' > /etc/vsftpd/vsftpd.conf

for conf in "${!VSFTPD_@}"; do
    opt=$(echo "${conf#"VSFTPD_"}" | tr "[:upper:]" "[:lower:]")
    printf '%s=%s\n' "$opt" "${!conf}"

    echo "$opt=${!conf}" >> /etc/vsftpd/vsftpd.conf
done

printf "\nStarting vsftpd\n"

exec /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
