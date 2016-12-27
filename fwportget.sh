#!/bin/bash

source openrc

curl -i -X GET \
   -H "X-Auth-Token:${TEST_TOKEN}" \
   -H "Accept:application/json" \
   -H "Content-Type:application/json" \
 "${EP_ESI}/v2.0/firewall_interfaces/$1"
