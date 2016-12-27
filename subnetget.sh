#!/bin/bash

source openrc

curl -i -X GET \
   -H "X-Auth-Token:${TEST_TOKEN}" \
   -H "Accept:application/json" \
   -H "Content-Type:application/json" \
 "http://network-lab3ec.gcv-cloud.com.local/v2.0/subnets/$1"
