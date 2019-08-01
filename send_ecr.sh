#!/bin/bash

# build + deploy script

set -e

source ./.env

# version=$(docker run --rm \
#     -v `pwd`:/app/:cached \
#     -w /app/ \
#       node:12.7-alpine /bin/sh \
#       -c 'node -p "require(\"./package.json\").version"')

version=latest

printf "\n\e[1;35mProcessing version $version\e[0m\n"

printf "\n\e[1;34mBuilding docker file (version $version)\e[0m\n\n"

docker build -t $AWS_ECR_IMAGE_NAME:$version .

printf "\n\e[1;34mGetting ECR Login\e[0m\n\n"

login_cmd=$(docker run --rm \
    -e AWS_REGION=$AWS_REGION \
    -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
    -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
    -v `pwd`:/app/:cached \
    -w /app/ \
      szanata/node-go-terraform-awscli:node8.10 /bin/bash \
      -c "aws ecr get-login --no-include-email --region us-east-1")

printf "\n\e[1;34mDoing ECR login\e[0m\n\n"

${login_cmd}

printf "\n\e[1;34mTagging image\e[0m\n\n"

docker tag $AWS_ECR_IMAGE_NAME:$version $AWS_ECR_REPOSITORY:$version

printf "\n\e[1;34mPushing to ECR\e[0m\n\n"

docker push $AWS_ECR_REPOSITORY:$version

printf "\n\e[1;92mAll Done!\e[0m\n\n"
