#!/bin/bash

source ./.env

hostprotocol="http"
if [ "$ELASTICSSL" = "true" ]; then
  hostprotocol="https"
fi

curl -X PUT -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/customer"
curl -X PUT -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/customer/_mapping" \
-H "Content-Type: application/json" \
-d @$PROJECTPATH/mapping/customer.json

curl -X PUT -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/_ingest/pipeline/customer_pipeline" \
-H "Content-Type: application/json" \
-d @$PROJECTPATH/pipeline/customer.json

logstashconf=`cat ${PROJECTPATH}/logstash/customer.conf`
logstashconf="${logstashconf//\#\#PROJECTPATH\#\#/"$PROJECTPATH"}"
logstashconf="${logstashconf//\#\#ELASTICHOST\#\#/"$ELASTICHOST"}"
logstashconf="${logstashconf//\#\#ELASTICSSL\#\#/"$ELASTICSSL"}"
logstashconf="${logstashconf//\#\#ELASTICUSER\#\#/"$ELASTICUSER"}"
logstashconf="${logstashconf//\#\#ELASTICPASS\#\#/"$ELASTICPASS"}"
/usr/share/logstash/bin/logstash -e "$logstashconf"

curl -X PUT -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/_enrich/policy/customer_policy" \
-H "Content-Type: application/json" \
-d @$PROJECTPATH/policy/customer.json

sleep 30
curl -X PUT -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/_enrich/policy/customer_policy/_execute"


