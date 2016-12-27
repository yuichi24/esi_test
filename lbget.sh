#!/bin/bash

source openrc

#tenant_query_check
TENANT="-t"
if [ $1 = $TENANT ]; then
	URL="${EP_ESI}/2.0/load_balancers?tenant_id=$2"
else
	URL="${EP_ESI}/2.0/load_balancers/$1"
fi

curl -i -X GET \
   -H "X-Auth-Token:${TEST_TOKEN}" \
   -H "Accept:application/json" \
   -H "Content-Type:application/json" \
   $URL
