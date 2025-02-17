#!/bin/sh

dir=/mnt/us/extensions/openssh

hostkey_rsa=$dir/etc/ssh_host_ed25519_key
hostkey_ecdsa=$dir/etc/ssh_host_ecdsa_key
hostkey_ed25519=$dir/etc/ssh_host_ed25519_key

# kill the server if it is running
if [ -f /var/run/sshd.pid ] && [ -d "/proc/$(cat /var/run/sshd.pid)" ]; then
/usr/sbin/eips 11 32 "kill running server"
kill -9 "$(cat /var/run/sshd.pid)"
fi

if [ ! -f /var/shadow ];then
cp -a /etc/shadow /var/shadow
# unlock root
sed -i "s|^root:!:|root:*:|" /var/shadow
mount --bind /var/shadow /etc/shadow
mount -o bind,remount,ro /etc/shadow
fi

if [ ! -f $hostkey_rsa ];then
/usr/sbin/eips 11 32 "Generate rsa host key"
$dir/bin/ssh-keygen -q -N "" -t rsa -f $hostkey_rsa
fi

if [ ! -f $hostkey_ecdsa ];then
/usr/sbin/eips 11 32 "Generate ecdsa host key"
$dir/bin/ssh-keygen -q -N "" -t ecdsa -f $hostkey_ecdsa
fi

if [ ! -f $hostkey_ed25519 ];then
/usr/sbin/eips 11 32 "Generate ed25519 host key"
$dir/bin/ssh-keygen -q -N "" -t ed25519 -f $hostkey_ed25519
fi


# use /var tmpfs
mkdir -p /var/etc/ssh /var/empty
chmod 750 /var/empty
install -Dm600 $hostkey_rsa /var/etc/ssh/ssh_host_rsa_key
install -Dm600 $hostkey_ecdsa /var/etc/ssh/ssh_host_ecdsa_key
install -Dm600 $hostkey_ed25519 /var/etc/ssh/ssh_host_ed25519_key
install -Dm644 ${hostkey_rsa}.pub /var/etc/ssh/ssh_host_rsa_key.pub
install -Dm644 ${hostkey_ecdsa}.pub /var/etc/ssh/ssh_host_ecdsa_key.pub
install -Dm644 ${hostkey_ed25519}.pub /var/etc/ssh/ssh_host_ed25519_key.pub

install -Dm640 $dir/etc/authorized_keys -t /var/etc/ssh/

# start the server
/usr/sbin/eips 11 32 "Starting..."

iptables -I INPUT -p tcp --dport 22 -j ACCEPT
sleep 1

$dir/sbin/sshd -E /var/log/sshd.log

/usr/sbin/eips 11 33 "Openssh Server started"
