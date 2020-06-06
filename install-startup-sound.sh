#!/bin/bash -e

if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi

echo
echo "Installing Startup Sound"


# WoodenBeaver sounds
mkdir -p /usr/local/share/sounds/WoodenBeaver/stereo
if [ ! -f /usr/local/share/sounds/WoodenBeaver/stereo/device-added.wav ]; then
    cp files/device-added.wav /usr/local/share/sounds/WoodenBeaver/stereo/
fi
if [ ! -f /usr/local/share/sounds/WoodenBeaver/stereo/device-removed.wav ]; then
    cp files/device-removed.wav /usr/local/share/sounds/WoodenBeaver/stereo/
fi

cat <<'EOF' > /etc/systemd/system/startup-sound.service
[Unit]
Description=Startup sound
After=multi-user.target

[Service]
Type=simple
ExecStart=/usr/bin/aplay -q /usr/local/share/sounds/WoodenBeaver/stereo/device-added.wav

[Install]
WantedBy=multi-user.target
EOF
systemctl enable startup-sound.service
