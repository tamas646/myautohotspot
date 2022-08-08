# myautohotspot
Automatize hotspot turning on and off depending on ethernet and wifi connections.

## Usage

This script can be run in two modes:

- if the MY_FILTER variable **is set**, then:
  - the Hotspot will turn on if the WiFi interface and the ethernet interface connects to the same network as defined in the variable
  - the Hotspot will turn off if the ethernet interface disconnects
- if the MY_FILTER variable **is not set**, then
  - the Hotspot will turn on if the ethernet interface connects to a network
  - the Hotspot will turn off if the ethernet interface disconnects

Before you start using it, you have to change the settings in `/etc/myautohotspot/config` to fit your hardware.

## Installation
- You can either [download](https://github.com/tamas646/myautohotspot/raw/main/myautohotspot_1.1.1_all.deb) and install the deb package or use the source code and setup it yourself.

- If you wish, you can install it from my apt repository too:

  ```sh
  sudo echo "deb [signed-by=/usr/share/keyrings/ptamas-pub.gpg] http://apt.ptamas.hu/main/ ./" > /etc/apt/sources.list.d/apt.ptamas.list
  wget -qO - https://apt.ptamas.hu/ptamas-pub.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/ptamas-pub.gpg > /dev/null
  apt update && apt install myautohotspot
  ```
