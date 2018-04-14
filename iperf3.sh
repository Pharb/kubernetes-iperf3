#!/usr/bin/env bash
set -eu

cd $(dirname $0)

steps/setup.sh
steps/run.sh $@
steps/cleanup.sh
