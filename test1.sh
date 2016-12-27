#!/bin/bash

source ./openrc

#試験項目を登録する
#COMMENT="syslogのリスト表示"
#
#echo `date +%Y/%m/%d`
#
#echo ""
#echo $COMMENT start
#echo ""


for i in `ls ./curl_script/cs*`;do
	echo "`cat $i`" ;
	echo;
	sh $i > ./TMP_OUTPUT1 2>/dev/null ;
	cat TMP_OUTPUT1 ;
	echo ;echo ;echo ;
done




#input fiind value
#v1=ip_address
#v2=`grep $v1 ./TMP_OUTPUT1 | cut -d ":" -f2`

#string or num
#echo $v2 | sed 's/"//g' | sed "s/,//g"
#echo $v2 | sed 's/,//g'


#curl -i -X GET
#    -H "X-Auth-Token:${TEST_TOKEN}"    -H "Accept:application/json"    -H "Content-Type:application/json"  http://network-lab3ec.gcv-cloud.com.local/v2.0/load_balancers/750dbb65-31a8-42ec-85db-71d27f1eb5bb


#ID1=`echo ./TMP_OUTPUT1 | grep id | head -1 | cut -d : -f2 | sed 's/"//g' | sed 's/,//'g`
#echo $ID1
