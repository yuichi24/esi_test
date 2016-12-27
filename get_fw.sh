#!/bin/bash

if [ $# -gt 2 ]; then
	echo "Error: get_nova.sh $1 $2 $3"
	echo "\$1 need firewall name"
	echo "\$2 need vnc; port; fw; vnf or null"
	echo "\$3 don't need "
	exit 1
elif [ $# -eq 0 ]; then
	echo "Error: get_nova.sh must be set arguments"
	echo "1st arg firewall name"
	echo "2nd arg vnc; port; fw; vnf or null"
	exit 1
fi

source openrc_fw

VNFID=`curl -s -X GET -H "X-Auth-Token:${TEST_TOKEN}" -H "Accept:application/json" -H "Content-Type:application/json"  "${EP_ESI}/firewalls?name=$1" | grep vnf_instance | awk '{print $2}' | sed 's/\"//g'`

VNFNAME=`curl -s -X GET -H "X-Auth-Token:${TEST_TOKEN}" -H "Accept:application/json" -H "Content-Type:application/json"  "${EP_ESI}/vnf_instances/$VNFID" | grep \"name | awk '{print $2}' | sed 's/\"//g' | sed 's/\,//'`

echo $VNFNAME

NOVAID=null
NOVAID=`curl -s -X GET -H "X-Auth-Token:${TEST_TOKEN}" -H "Accept:application/json"    -H "Content-Type:application/json"  "${EP_NOVA}/servers?name=$VNFNAME" | jq -r '.servers[].id'`

if [ -z ${NOVAID[*]} ]; then
	echo
	echo
	echo "Error: $1 is not found"
	exit 1
fi

case "$2" in
 "" ) echo ;;

 "vnc" ) curl -i -X POST -H "X-Auth-Token:${TEST_TOKEN}" -H "Accept:application/json" -H "Content-Type:application/json" -d '{ "os-getVNCConsole":{"type":"novnc" }}' "${EP_NOVA}/servers/${NOVAID}/action" ;;

 "port" ) curl -i -X GET -H "X-Auth-Token:${TEST_TOKEN}" -H "Accept:application/json"    -H "Content-Type:application/json"  "${EP_ESI}/ports?device_id=${NOVAID}" ;;

 "vnf" ) curl -i -X GET -H "X-Auth-Token:${TEST_TOKEN}" -H "Accept:application/json"    -H "Content-Type:application/json"  "${EP_ESI}/vnf_instances/$VNFID" ;;

 "fw" ) curl -i -X GET -H "X-Auth-Token:${TEST_TOKEN}" -H "Accept:application/json"    -H "Content-Type:application/json"  "${EP_ESI}/firewalls?name=$1" ;;

 "ip" ) curl -s -X GET -H "X-Auth-Token:${TEST_TOKEN}" -H "Accept:application/json" -H "Content-Type:application/json" "http://nova-lab3ec.gcv-cloud.com.local/v2/541839f0e6d94455bb4a4b8539f8c1b5/servers/${NOVAID}" | jq -r ".server.addresses.vfw_admin_network01[].addr" ;;

 * )
	echo
	echo
	echo "second argument is vnc; port; fw; vnf or null"
	exit 1
esac


echo "Server ID is ${NOVAID}"

for i in ${NOVAID[@]}
do
curl -s -X GET -H "X-Auth-Token:${TEST_TOKEN}" -H "Accept:application/json" -H "Content-Type:application/json"  "http://nova-lab3ec.gcv-cloud.com.local/v2/541839f0e6d94455bb4a4b8539f8c1b5/servers/$i" | jq '.'
done

