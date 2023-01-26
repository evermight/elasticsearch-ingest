#!/bin/bash

source ./.env

hostprotocol="http"
if [ "$ELASTICSSL" = "true" ]; then
  hostprotocol="https"
fi

curl -X PUT -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/order"
curl -X PUT -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/order/_mapping" \
-H "Content-Type: application/json" \
-d @$PROJECTPATH/mapping/order.json

curl -X PUT -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/_ingest/pipeline/order_pipeline" \
-H "Content-Type: application/json" \
-d @$PROJECTPATH/pipeline/order.json

logstashconf=`cat ${PROJECTPATH}/logstash/order.conf`
logstashconf="${logstashconf//\#\#PROJECTPATH\#\#/"$PROJECTPATH"}"
logstashconf="${logstashconf//\#\#ELASTICHOST\#\#/"$ELASTICHOST"}"
logstashconf="${logstashconf//\#\#ELASTICSSL\#\#/"$ELASTICSSL"}"
logstashconf="${logstashconf//\#\#ELASTICUSER\#\#/"$ELASTICUSER"}"
logstashconf="${logstashconf//\#\#ELASTICPASS\#\#/"$ELASTICPASS"}"
/usr/share/logstash/bin/logstash -e "$logstashconf"
