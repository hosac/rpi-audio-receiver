#!/bin/bash -e

if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi

THENAME="DLNA/UPnP renderer (gmrender-resurrect)"


install-source() {
    echo
    echo "Building "$THENAME" from source code..."

    # Install dependencies
    apt -y install build-essential autoconf automake libtool pkg-config git
    apt -y install libupnp-dev libgstreamer1.0-dev 
    apt -y install gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav
    # Use either ALSA or Pulse
    apt -y install gstreamer1.0-alsa
    #apt -y install gstreamer1.0-pulseaudio
    # Clone
    git clone https://github.com/hzeller/gmrender-resurrect.git
    # Build, make and install
    cd gmrender-resurrect
    ./autogen.sh
    ./configure
    make
    make install

cat <<'EOF' > /etc/systemd/system/gmrender-resurrect.service
[Unit]
Description=gmrender-resurrect service
After=network.target sound.target

[Service]
ExecStartPre=/bin/sh -c "/bin/systemctl set-environment UPNP_DEVICE_NAME=$(hostname)"
ExecStartPre=/bin/sh -c "/bin/systemctl set-environment UPNP_UUID=$(ip link show | awk '/ether/ {print \"salt:)-\" $2}' | head -1 | md5sum | awk '{print $1}')"
ExecStart=/usr/local/bin/gmediarender -f ${UPNP_DEVICE_NAME} -u ${UPNP_UUID} --gstout-audiosink=alsasink --gstout-audiodevice=sysdefault --logfile=/tmp/gmediarenderer.log --gstout-initial-volume-db=-20
Restart=always

[Install]
WantedBy=multi-user.target
EOF

    # Enable and start service
    systemctl enable --now gmrender-resurrect.service
}


# Choose option
install-source
