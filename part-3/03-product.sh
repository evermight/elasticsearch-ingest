#!/bin/bash

source ./.env

hostprotocol="http"
if [ "$ELASTICSSL" = "true" ]; then
  hostprotocol="https"
fi










logstashconf=`cat ${PROJECTPATH}/logstash/product.conf`
logstashconf="${logstashconf//\#\#PROJECTPATH\#\#/"$PROJECTPATH"}"
logstashconf="${logstashconf//\#\#ELASTICHOST\#\#/"$ELASTICHOST"}"
logstashconf="${logstashconf//\#\#ELASTICSSL\#\#/"$ELASTICSSL"}"
logstashconf="${logstashconf//\#\#ELASTICUSER\#\#/"$ELASTICUSER"}"
logstashconf="${logstashconf//\#\#ELASTICPASS\#\#/"$ELASTICPASS"}"
/usr/share/logstash/bin/logstash -e "$logstashconf"

curl -X PUT -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/_enrich/policy/product_policy" \
-H "Content-Type: application/json" \
-d @$PROJECTPATH/policy/product.json

sleep 60
curl -X PUT -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/_enrich/policy/product_policy/_execute"


