#!/bin/bash

set -ex

PREFIX=/mnt/us/extensions/openssh
export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig
pushd ~

#if [ ! -e "$PREFIX/bin/openssl" ]; then
#curl -L https://github.com/openssl/openssl/releases/download/OpenSSL_1_1_1w/openssl-1.1.1w.tar.gz >  openssl-1.1.1w.tar.gz
#tar -xf openssl-*.tar.gz
#pushd openssl-*
#    ./config --prefix=$PREFIX threads shared -Wl,--rpath=$PREFIX/lib
#    make -j 8
#    make install_sw install_ssldirs 
#popd
#fi

# 9.3p2 is the last version with 1.0.x support
wget https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-9.3p2.tar.gz
tar -xf openssh-*.tar.gz
pushd openssh-*
    ./configure --prefix=$PREFIX
    make -j 8
    make install-nokeys
popd

popd

# write sshd_config
cat << EOF > $PREFIX/etc/sshd_config
LogLevel VERBOSE

HostKey /var/etc/ssh/ssh_host_rsa_key
HostKey /var/etc/ssh/ssh_host_ecdsa_key
HostKey /var/etc/ssh/ssh_host_ed25519_key

PubkeyAuthentication yes
PasswordAuthentication no
PermitRootLogin yes

AuthorizedKeysFile /var/etc/ssh/authorized_keys
StrictModes no

Subsystem	sftp	/mnt/us/extension/openssh/libexec/sftp-server

AcceptEnv LANG LC_ALL LC_COLLATE LC_CTYPE LC_MESSAGES LC_MONETARY LC_NUMERIC LC_TIME LANGUAGE LC_ADDRESS LC_IDENTIFICATION LC_MEASUREMENT LC_NAME LC_PAPER LC_TELEPHONE

AcceptEnv COLORTERM
EOF
