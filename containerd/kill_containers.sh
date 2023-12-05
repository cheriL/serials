#!/bin/bash

ctr -n k8s.io t ls | awk '{print $1}' | grep -v TASK | while read -r task; do
    ctr -n k8s.io t kill "$task"
done

ctr -n k8s.io c ls | awk '{print $1}' | grep -v CONTAINER | while read -r container; do
    ctr -n k8s.io c rm "$container"
done