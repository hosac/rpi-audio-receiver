<h1>Raspberry Pi Audio Receiver</h1>

A fork of https://github.com/nicokaiser/rpi-audio-receiver.
It contains some modifications and additional packages. 

<h2>Special branch</h2>

This is a special branch for the "pflanzi" project.<br> 
In contrast to the master branch the scripts have no choice of installation variants - they are pre-selected. Scripts must be started individually.<br>
Please find more information about the project in the leaflet on https://hosac.github.io/pflanzi

<h2>Features</h2>

A simple, light weight audio receiver with Bluetooth (A2DP), AirPlay, Spotify Connect and UPnP. Devices like phones, tablets and computers can play audio via this receiver.

<h2>Requirements</h2>

- Focus is on the two audio cards [Waveshare WM8960 HAT](https://www.waveshare.com/wm8960-audio-hat.htm) and [HiFiBerry MiniAmp](https://www.hifiberry.com/shop/boards/miniamp/) which fit into the housing of the project together with a Raspberry Pi Zero WH.
- Please use always latest "lite" image from [official source](https://www.raspberrypi.org/downloads/raspbian).

<h2>Prerequisites</h2>

Make sure you have a updated system

	sudo apt-get update
	sudo apt-get upgrade -y
	
	# if you are not using the newest image and the kernel got a new minor version, 
	# please do a reboot to avoid issues!
	sudo reboot

<h2>Installation</h2>

Each script has to be executed manually.

	wget -q https://github.com/hosac/rpi-audio-receiver/archive/pflanzi.zip
	unzip pflanzi.zip
	rm pflanzi.zip
	cd rpi-audio-receiver-pflanzi

	# execute the dedicated script, e.g.
	# sudo ./install-upnp.sh

<h3>Components</h3>

<h4>Bluetooth</h4>

Sets up Bluetooth, adds a simple agent that accepts every connection, and enables audio playback through [BlueALSA](https://github.com/Arkq/bluez-alsa). A udev script is installed that disables discoverability while connected.

<h4>AirPlay</h4>

AirPlay is used by Apple devices with iOS, iPadOS and MacOS. The script installs [Shairport Sync](https://github.com/mikebrady/shairport-sync) AirPlay Audio Receiver. It comes with a backported version of shairport-sync from Raspbian Bullseye (see [SimpleBackportCreation](https://wiki.debian.org/SimpleBackportCreation) for details).

<h4>Spotify Connect</h4>

Installs [Spotifyd](https://github.com/Spotifyd/spotifyd), an open source Spotify client.

<h4>DLNA/UPnP</h4>

DLNA/UPnP is used by several clients. Windows Media Player supports it out of the box. For Android [Bubble UPnP](https://play.google.com/store/apps/details?id=com.bubblesoft.android.bubbleupnp&hl=com) is a recommended app. The script installs [gmrender-resurrect](http://github.com/hzeller/gmrender-resurrect) UPnP Renderer.

<h4>Snapcast</h4>

Installs [snapclient](https://github.com/badaix/snapcast), the client component of the Snapcast Synchronous multi-room audio player.

<h4>Startup-Sound</h4>

A system sound will be installed, which is played at every system startup or when a bluetooth connection is established.

<h3>Hardware</h3>

<h4>HiFiBerry MiniAmp</h4>

Setup process for MiniAmp hardware from the [HiFiBerry family](https://www.hifiberry.com/).

<h4>Waveshare WM8960 Audio-HAT  </h4>

The [Waveshare WM8960 HAT](https://www.waveshare.com/wm8960-audio-hat.htm), a I2C/I2S card. As this hardware is not part of the Linux kernel it will be built locally. Note: the installation script has issues after an update to a new kernel minor version without previous reboot.

<h2>Limitations</h2>

- Only one Bluetooth device can be connected at a time, otherwise interruptions may occur.
- The device is always open, new clients can connect at any time without authentication.

<h2>Disclaimer</h2>

These scripts are tested and work on a current (as of January 2020) Raspbian setup on Raspberry Pi. Depending on your setup (board, configuration, sound module, Bluetooth adapter) and your preferences, you might need to adjust the scripts. They are held as simple as possible and can be used as a starting point for additional adjustments.

<h2>References</h2>

- [BlueALSA: Bluetooth Audio ALSA Backend](https://github.com/Arkq/bluez-alsa)
- [Shairport Sync: AirPlay Audio Receiver](https://github.com/mikebrady/shairport-sync)
- [Spotifyd: open source Spotify client](https://github.com/Spotifyd/spotifyd)
- [gmrender-resurrect: Headless UPnP Renderer](http://github.com/hzeller/gmrender-resurrect)
- [Snapcast: Synchronous audio player](https://github.com/badaix/snapcast)
- [pivumeter: ALSA plugin for displaying VU meters on various Raspberry Pi add-ons](https://github.com/pimoroni/pivumeter)
- [Adafruit: Read-Only Raspberry Pi](https://github.com/adafruit/Raspberry-Pi-Installer-Scripts/blob/master/read-only-fs.sh)
