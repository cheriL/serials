#!/bin/bash

set -e
set -x

dev=$(losetup  | grep kata-containers | awk '{ print $1}')
f=$(basename $dev)

umount ./mnt
kpartx -d $dev
losetup -d $dev