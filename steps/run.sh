#!/usr/bin/env bash
set -eu

CLIENTS=$(kubectl get pods -l app=iperf3-client -o name | cut -d'/' -f2)

for POD in ${CLIENTS}; do
    HOST=$(kubectl get pod ${POD} -o jsonpath='{.status.hostIP}')
    kubectl exec -it ${POD} -- iperf3 -c iperf3-server -T "Client on ${HOST}" $@
done
