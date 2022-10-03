#!/bin/bash -ex

ARCH=$(arch)

# Adding a safe download backup since SourceForge goes offline frequently
VGL64VER=2.6.5
#VGL64="https://downloads.sourceforge.net/project/virtualgl/$VGL64VER/virtualgl_${VGL64VER}_amd64.deb"
VGL64="https://storage.googleapis.com/app_archive/virtualgl/virtualgl_${VGL64VER}_amd64.deb"
dirname=$(dirname $0)

export DEBIAN_FRONTEND=noninteractive
apt-get -y update
apt -y install task-xfce-desktop
apt-get -y install wget

if [[ "$ARCH" != "x86_64" ]]; then
    echo "non-x86_64 has no VirtualGL"
else
    cd /tmp
    wget --content-disposition "$VGL64"
    dpkg --install virtualgl*.deb || apt-get -f install
    rm -f virtualgl*.deb
fi

PY2=$(python -V 2>&1 |grep "^Python 2" || true)
if [[ -n "$PY2" ]]; then

    # this clobbers py3 only, so do it only if we have py2
    apt-get -y install python-pip libmagickwand-dev python-gtk2 python-gnome2 python-numpy

    # Wand is used for screenshots
    pip install Wand
fi

apt-get clean

. $dirname/postinstall-desktop.sh
