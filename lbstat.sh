#!/bin/bash

source openrc_lb

CODE=$( curl -i "${EP_ESI}/load_balancers/$1" \
            -X GET -H "X-Auth-Token:${TEST_TOKEN}" -H "Accept:application/json" \
            -H "Content-Type:application/json" \
	| grep HTTP )
echo ${CODE}

while true ;do
	STATUS=$( curl -s "${EP_ESI}/load_balancers/$1" \
            -X GET -H "X-Auth-Token:${TEST_TOKEN}" -H "Accept:application/json" \
            -H "Content-Type:application/json" \
            | jq -r ".load_balancer.status" )
        echo ${STATUS};
        case "${STATUS}" in
		PENDIG*)
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
	echo -n wait;sleep 1;
	for i `seq 10`; do
		echo -n .;sleep 1;
`	done
done

echo "### Finish task ###"


