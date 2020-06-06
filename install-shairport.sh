#!/bin/bash -e

if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi

THENAME="Shairport Sync AirPlay Audio Receiver"


install-source() {
    echo
    echo "Building "$THENAME" from source code..."
    # Dependencies
    sudo apt-get -y install build-essential git xmltoman autoconf automake libtool libpopt-dev libconfig-dev libasound2-dev avahi-daemon libavahi-client-dev libssl-dev libsoxr-dev
    # Clone, build and install
    git clone https://github.com/mikebrady/shairport-sync.git
    cd shairport-sync
    autoreconf -fi
    ./configure --sysconfdir=/etc --with-alsa --with-soxr --with-avahi --with-ssl=openssl --with-systemd
    make
    sudo make install
}

do-settings() {
    echo "Do some settings..."

# Wait for avahi
mkdir -p /etc/systemd/system/shairport-sync.service.d
cat <<'EOF' > /etc/systemd/system/shairport-sync.service.d/override.conf
[Service]
# Avahi daemon needs some time until fully ready
ExecStartPre=/bin/sleep 3
EOF

# Configuration file	
cat <<'EOF' > "/etc/shairport-sync.conf"
alsa = {
//  mixer_control_name = "Softvol"; // Note: Softvol increases the CPU workload dramatically. Not recommended to use it on Pi Zero.
};

sessioncontrol = {
    session_timeout = 20;
};
EOF

    # enable and start service
    systemctl enable --now shairport-sync
}

# Choose option
install-source
do-settings
