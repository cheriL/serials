#!/bin/bash

mount | grep containerd | awk '{print $3}' | while read -r mountpoint; do
    sudo umount "$mountpoint"
done