#!/bin/bash

source ./openrc

FWID=0ee9a91a-a8d9-4fee-86bb-eaf13c283c51

for i in `seq 100` ;do
	echo ;
	echo "###vyatta 4.2S1R1 reboot long term test $i  `date +"%Y/%m/%d %H:%M:%S"`";
	echo ;
	curl -i -X POST \
	   -H "X-Auth-Token:${TEST_TOKEN}" \
	   -H "Accept:application/json" \
	   -H "Content-Type:application/json" \
	   -d \
	'{ "type": "HARD" }' \
	 "http://network-lab3ec.gcv-cloud.com.local/v2.0/firewalls/${FWID}/reboot";
	echo;
	./fwstat.sh ${FWID}
	sleep 30
	source ./openrc
done




