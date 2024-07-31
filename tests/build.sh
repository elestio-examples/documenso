#!/usr/bin/env bash

cp -r ./docker/* ./

docker buildx build . --output type=docker,name=elestio/documenso:latest | docker load