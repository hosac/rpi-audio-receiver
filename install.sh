#!/bin/bash -e

echo "--- Installing components ---"
sudo ./install-bluetooth.sh
sudo ./install-shairport.sh
sudo ./install-spotify.sh
sudo ./install-upnp.sh
sudo ./install-snapcast-client.sh
sudo ./install-startup-sound.sh
sudo ./install-pivumeter.sh
echo "--- Installing hardware ---"
sudo ./enable-hifiberry.sh
sudo ./enable-waveshare.sh
echo "--- Doing reboot ---"
sudo reboot
