#!/bin/bash

source openrc

curl -i -X DELETE \
   -H "X-Auth-Token:${TEST_TOKEN}" \
   -H "Accept:application/json" \
   -H "Content-Type:application/json" \
 "${EP_ESI}/v2.0/firewalls/$1"
