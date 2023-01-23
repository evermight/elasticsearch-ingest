#!/bin/bash

source ./.env

hostprotocol="http"
if [ "$ELASTICSSL" = "true" ]; then
  hostprotocol="https"
fi

curl -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/order"
curl -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/_ingest/pipeline/order_pipeline"

curl -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/orderitem"
curl -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/_enrich/policy/orderitem-policy"
curl -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/_ingest/pipeline/orderitem_pipeline"

curl -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/product"
curl -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/_enrich/policy/product-policy"

curl -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/customer"
curl -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/_enrich/policy/customer-policy"
curl -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/_ingest/pipeline/customer_pipeline"

curl -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/zipgeo"
curl -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/_enrich/policy/zipgeo-policy"


