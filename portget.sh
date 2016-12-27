#!/bin/bash

source openrc

#tenant query check
TENANT="-t"
if [ $1 = $TENANT ]; then
	URL="${EP_ESI}/v2.0/ports?tenant_id=$2"
else
	URL="${EP_ESI}/v2.0/ports/$1"
fi

#curl GET
curl -i -X GET \
   -H "X-Auth-Token:${TEST_TOKEN}" \
   -H "Accept:application/json" \
   -H "Content-Type:application/json" \
   $URL
