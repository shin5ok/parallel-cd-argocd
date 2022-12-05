#!/bin/bash

for v in {1..3};
do
    echo gcloud container clusters create cluster-$v --zone=us-central1-a --num-nodes 2 --async --quiet --workload-pool=$PROJECT.svc.id.goog $@
done