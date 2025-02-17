#!/bin/bash

set -ex 

apt install -y --force-yes cmake

pkgname=fastfetch
pkgver=2.36.1
url="https://github.com/fastfetch-cli/fastfetch"

wget ${url}/archive/refs/tags/${pkgver}.tar.gz
tar -xf *.tar.gz

cmake -B build -S "${pkgname}-${pkgver}" \
	-DCMAKE_BUILD_TYPE='RelWithDebInfo' \
	-DCMAKE_INSTALL_PREFIX='/mnt/us/extensions/fastfetch' \
	-DBUILD_TESTS='OFF'

cmake --build build
cmake --install build
