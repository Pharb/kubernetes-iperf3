#!/usr/bin/env bash
set -eu

kubectl create -f iperf3.yaml

until $(kubectl get pods -l app=iperf3-server -o jsonpath='{.items[0].status.containerStatuses[0].ready}'); do
    echo "Waiting for iperf3 server to start..."
    sleep 5
done

echo "Server is running"
echo
