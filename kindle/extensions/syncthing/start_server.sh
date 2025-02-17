#!/bin/sh

dir=/mnt/us/extensions/syncthing

$dir/stop_server.sh

/usr/sbin/eips 11 32 "Starting..."

iptables -I INPUT -p tcp --dport 8384 -j ACCEPT
iptables -I INPUT -p tcp --dport 22000 -j ACCEPT
iptables -I INPUT -p udp --dport 22000 -j ACCEPT
sleep 1

nohup $dir/bin/syncthing serve --gui-address="http://0.0.0.0:8384" --config=$dir/config --data=$dir/data --no-upgrade &> $dir/syncthing.log &

/usr/sbin/eips 11 32 "Syncthing started"
