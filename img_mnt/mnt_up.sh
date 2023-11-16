#!/bin/bash

set -e
set -x

img_file=./kata-containers.img
losetup  -f $img_file
dev=$(losetup  | grep kata-containers | awk '{ print $1}')
f=$(basename $dev)
kpartx -a $dev
mount /dev/mapper/${f}p1 ./mnt