#!/bin/bash

source ./.env

hostprotocol="http"
if [ "$ELASTICSSL" = "true" ]; then
  hostprotocol="https"
fi

curl -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/order"
curl -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/_ingest/pipeline/order_pipeline"

curl -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/order_item"
curl -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/_enrich/policy/order_item_policy"
curl -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/_ingest/pipeline/order_item_pipeline"

curl -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/product"
curl -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/_enrich/policy/product_policy"

curl -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/customer"
curl -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/_enrich/policy/customer_policy"
curl -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/_ingest/pipeline/customer_pipeline"

curl -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/zip_geo"
curl -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/_enrich/policy/zip_geo_policy"


