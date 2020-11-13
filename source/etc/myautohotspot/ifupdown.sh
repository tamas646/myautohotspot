#!/bin/bash

CONFFILE="/etc/myautohotspot/config"
[[ -f "$CONFFILE" ]] || exit 0
. "$CONFFILE"
[[ "$MY_ENABLED" == "1" && -n "$MY_ETH_IF" && -n "$MY_WLAN_IF" && -n "$MY_HOTSPOT_CONNECTION_NAME" ]] || exit 0

case "$PHASE" in
	post-up)
			if [[ "$IFACE" == "$MY_ETH_IF" || "$IFACE" == "$MY_WLAN_IF" ]] && [[ -n "$(nmcli connection show |grep "\s${MY_ETH_IF}\s*\$")" ]] && [[ ! -n "$(nmcli connection show |grep "^${MY_HOTSPOT_CONNECTION_NAME}\s.*\s${MY_WLAN_IF}\s*\$")" ]]
			then
				# if ethernet and wifi is connected to the same network
				IFS='%'
				if [[ -n "$(ifconfig $MY_ETH_IF |grep "$MY_FILTER")" ]] && [[ -n "$(ifconfig $MY_WLAN_IF |grep "$MY_FILTER")" ]]
				then
					# turn on hotspot
					nmcli connection up $MY_HOTSPOT_CONNECTION_NAME || exit 0
				fi
				unset IFS
			fi
		;;
	post-down)
			if [[ "$IFACE" == "$MY_ETH_IF" ]]
			then
				# if ethernet is connected to the network described above and the hotspot is active
				if [[ -n "$(nmcli connection show |grep "^${MY_HOTSPOT_CONNECTION_NAME}\s.*\s${MY_WLAN_IF}\s*\$")" ]]
				then
					# turn off hotspot
					nmcli connection down $MY_HOTSPOT_CONNECTION_NAME || exit 0
				fi
			fi
		;;
esac

exit 0
