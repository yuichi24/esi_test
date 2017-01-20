#!/bin/bash

#Argument Error check
if [ $# -gt 2 ]; then
	echo "Error: fwstat.sh $1 $2 $3"
	echo "Usage: fwstat.sh [FW_UUID]"
	exit 1
elif [ $# -eq 0 ]; then
	echo "Error: fwstat.sh must be set argument"
	echo "Usage: fwstat.sh [FW_UUID]"
	exit 1
fi

source openrc_fw

#CODE=$( curl -i "${EP_ESI}/firewalls/$1" \
#            -X GET -H "X-Auth-Token:${TEST_TOKEN}" -H "Accept:application/json" \
#            -H "Content-Type:application/json" \
#	| grep HTTP )
#echo ${CODE}

while true ;do

	#get fw status
	STATUS=$( curl -s "${EP_ESI}/firewalls/$1" \
            -X GET -H "X-Auth-Token:${TEST_TOKEN}" -H "Accept:application/json" \
            -H "Content-Type:application/json" \
            | jq -r ".firewall.status" )

	#display fw status
        echo -n ${STATUS};

	#check fw status
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

	#wati status_check for 10 sec
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
exit 0

