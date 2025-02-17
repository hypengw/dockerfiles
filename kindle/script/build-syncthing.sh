#!/bin/bash

set -ex 

git clone https://github.com/syncthing/syncthing.git
cd syncthing
git checkout v1.29.2

go run build.go
install -Dm755 ./bin/* -t /mnt/us/extensions/syncthing/bin
