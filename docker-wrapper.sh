#!/bin/bash

#
# This wrapper needs to have
#   HOME_DIR

HOME_DIR="${HOME_DIR:-$PWD}"

# Check we are in the right directory
docker run --rm \
	-it \
	-e HOME=/home/$USER -v $HOME:/home/$USER \
	-e USER \
	-u $(id -u):$(id -g) \
	$(id -Gz | xargs -0 -n1 -I{} echo "--group-add={}") \
	-h openwrt-builder \
	-v $HOME_DIR:$HOME_DIR \
	-w $HOME_DIR \
	irishmarco/openwrt-builder:18.04 bash
