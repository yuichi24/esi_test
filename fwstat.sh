#!/bin/bash

source openrc_fw

CODE=$( curl -s "${EP_ESI}/firewalls/$1" \
            -X GET -H "X-Auth-Token:${TEST_TOKEN}" -H "Accept:application/json" \
            -H "Content-Type:application/json" \
	| grep HTTP )
echo ${CODE}

while true ;do
	STATUS=$( curl -s "${EP_ESI}/firewalls/$1" \
            -X GET -H "X-Auth-Token:${TEST_TOKEN}" -H "Accept:application/json" \
            -H "Content-Type:application/json" \
            | jq -r ".firewall.status" )
        echo -n ${STATUS};
        case "${STATUS}" in
		PENDING*)
		;;
		ERROR)
			break
		;;
		ACTIVE)
			break
		;;
		*)
			break
		;;
        esac
	echo -n "  ";
	echo -n `date +"%Y/%m/%d %H:%M:%S"`;
	echo ;
	echo -n wait;sleep 1;
	for i in `seq 10` ;do
		echo -n .;sleep 1;
	done
done

echo ;echo
echo "### fwstat.sh Finish ###"


