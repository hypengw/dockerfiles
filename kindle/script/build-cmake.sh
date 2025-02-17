#!/bin/bash

set -ex

pkgname=cmake
pkgver=3.31.5

wget "https://gitlab.kitware.com/cmake/cmake/-/archive/v3.31.5/cmake-v3.31.5.tar.gz"
tar -xf *.tar.gz
pushd cmake-*

./bootstrap --prefix=/usr/local \
  --parallel=8
make -j8
make install

popd
