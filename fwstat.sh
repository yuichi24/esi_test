#!/bin/bash

source openrc_fw

while true ;do
	sleep 10
	local STATUS=$( curl -s ${EP_NETWORK}/v2.0/firewalls/$1" \
		-X GET -H "X-Auth-Token:${TOKEN}" -H "Accept:application/json" \
		-H "Content-Type:application/json" \
		| jq -r ".firewall.status" )
	echo ${STATUS}
	case "${STATUS}" in
		ERROR)
			break
			;;
		ACTIVE)
			break
			;;
	esac
done

	echo "### Finish task ###"
}

