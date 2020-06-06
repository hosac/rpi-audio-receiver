#!/bin/bash -e

if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi

THENAME="Snapcast Client (snapclient)"

install-apt() {
    echo
    echo "Installing "$THENAME
    apt install --no-install-recommends -y snapclient
}


# Choose option
echo
install-apt
