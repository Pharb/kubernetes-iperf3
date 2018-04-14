#!/usr/bin/env bash
set -eu

kubectl delete --cascade -f iperf3.yaml
