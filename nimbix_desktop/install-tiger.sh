#!/bin/bash

VERSION=1.10.1
ARCH=$(arch)

if [ "$ARCH" != "x86_64" ]; then
    #build_and_install_tiger
    retlsb=$(lsb_release -i | awk '{print $3}')
    shopt -s nocasematch 
    if [[ -f /etc/redhat-release ]]; then
        sudo yum -y install tigervnc-server
    elif [[ ${retlsb} =~ ^(ubuntu|debian) ]]; then 
        sudo apt-get -y update
        sudo apt-get -y install tigervnc-standalone-server
    fi
    shopt -u nocasematch 	
else
    # Install the cached tarball
    sudo tar -C / -xzf  /usr/local/lib/nimbix_desktop/tigervnc-$VERSION.$ARCH.tar.gz --strip-components=1

    # Fix newer installs that put binary in /usr/libexec
#    if [[ -x /usr/libexec/vncserver ]]; then
#      ln -sf /usr/libexec/vncserver /usr/bin/vncserver
#    fi

fi

sudo cp /usr/local/lib/nimbix_desktop/help-tiger.html /etc/NAE/help.html
