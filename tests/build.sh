#!/usr/bin/env bash

rm -rf ./docker/build.sh
cp -r ./docker/* ./

docker buildx build . --output type=docker,name=elestio4test/documenso:latest | docker load
