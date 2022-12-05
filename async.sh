#!/bin/bash
set -e

YAML=my-apache2.yaml
RESULTS=()
CLUSTERS=(test-1 test-2)
ZONE=us-central1-a

n=1
for cluster in ${CLUSTERS[@]}
do
    fd="Task${n}"
    eval "exec {$fd}< <( docker run -e CLOUDSDK_COMPUTE_ZONE=$ZONE -v `pwd`:/var/tmp -e CLOUDSDK_CONTAINER_CLUSTER=$cluster gcr.io/cloud-builders/kubectl apply -f /var/tmp/$yaml )"
    n=$(expr $n + 1)
    RESULTS=("${RESULTS[@]}" $fd) 
done

for fd in ${RESULTS[@]}
do
    echo $fd
    eval "cat <&${!fd}"
done