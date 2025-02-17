#!/bin/sh

function show_ip {
myip="$(ifconfig | grep -A 1 'wlan0' | tail -1 | cut -d ':' -f 2 | cut -d ' ' -f 1)"
if [ -z "$myip" ]
then
  /usr/sbin/eips 11 33 "No Wifi connection detected"
else
  /usr/sbin/eips 11 33 "Listening on: $myip:22"
fi
}

#check if sshd is running
if [ -f /var/run/sshd.pid ] && [ -d "/proc/$(cat /var/run/sshd.pid)" ]; then
  /usr/sbin/eips 11 32 "Openssh Server is RUNNING"
  show_ip
else
  /usr/sbin/eips 11 32 "Openssh Server is NOT running"
fi

logfile=/var/log/sshd.log
eips 11 35 "log:"
col=35
if [ -f $logfile ];then
tail -n 20 $logfile | while IFS= read -r line; do
    let col++
    line=$(echo -n "$line" | sed "s/'//g")
    eips 11 $col "$(echo -n "$line" | cut -c 0-56 -)"
done
fi
