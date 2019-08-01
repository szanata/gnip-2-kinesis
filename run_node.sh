#!/bin/bash

set -e

source ./.env

echo $AWS_REGION
docker run --rm -it \
  -e NODE_ENV="development" \
  -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
  -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
  -e AWS_REGION=$AWS_REGION \
  -e GNIP_URL=$GNIP_URL \
  -e GNIP_USERNAME=$GNIP_USERNAME \
  -e GNIP_PASSWORD=$GNIP_PASSWORD \
  -e KINESIS_STREAM_NAME=$KINESIS_STREAM_NAME \
  -v `pwd`:/app/ \
  -w /app/ \
    node:12.7-alpine /bin/sh
