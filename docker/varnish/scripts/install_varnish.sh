#!/bin/bash
VARNISH_MAJOR_VERSION=$1
VMOD_DOWNLOAD_DIR="/usr/src/"
VMOD_BUILD_DIR="/usr/src/varnish-modules"
VMOD_GIT_REPO="https://github.com/varnish/varnish-modules"

# install varnish
apt-get -y update
apt-get -y install curl && apt-get -y install sudo
curl -s https://packagecloud.io/install/repositories/varnishcache/varnish${VARNISH_MAJOR_VERSION}/script.deb.sh | sudo bash
apt-get -y update
apt-get -y install varnish

if [ $? -ne 0 ]; then
    echo "Error occured while installing varnish"
    exit 1
fi

# install varnish vmods
apt-get -y install build-essential git automake libtool docutils-common varnish-dev

mkdir -p ${VMOD_DOWNLOAD_DIR}
cd ${VMOD_DOWNLOAD_DIR}
git clone ${VMOD_GIT_REPO}

cd ${VMOD_BUILD_DIR}
./bootstrap
./configure
make
make check

if [ $? -ne 0 ]; then
    echo "Error occured while building varnish vmods"
    exit 1
fi

make install
