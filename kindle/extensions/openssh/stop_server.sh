#!/bin/sh

if [ -f /var/run/sshd.pid ] && [ -d "/proc/$(cat /var/run/sshd.pid)" ]; then
/usr/sbin/eips 11 32 "kill running server"
kill -9 "$(cat /var/run/sshd.pid)"
fi

/usr/sbin/eips 11 32 "Openssh Server stopped"
