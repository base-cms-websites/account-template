#!/bin/bash
set -e

IMAGE=basecmswebsites/$1:$2
yarn global add @endeavorb2b/rancher2cli
r2 dl basecms-website $1 $IMAGE --namespace=$3
