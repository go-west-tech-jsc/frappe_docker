#!/bin/bash

set -e

cd /home/frappe/frappe-bench
bench set-config -g socket_port 9000
if [ -n "$CUSTOM_APP1_NAME" ] && [ -n "$CUSTOM_APP1_REPO" ] && [ -n "$CUSTOM_APP1_BRANCH" ]; then
  bench get-app --branch=${CUSTOM_APP1_BRANCH} --resolve-deps ${CUSTOM_APP1_NAME} ${CUSTOM_APP1_REPO}
fi

if [ -n "$CUSTOM_APP2_NAME" ] && [ -n "$CUSTOM_APP2_REPO" ] && [ -n "$CUSTOM_APP2_BRANCH" ]; then
  bench get-app --branch=${CUSTOM_APP2_BRANCH} --resolve-deps ${CUSTOM_APP2_NAME} ${CUSTOM_APP2_REPO}
fi

if [ -n "$CUSTOM_APP3_NAME" ] && [ -n "$CUSTOM_APP3_REPO" ] && [ -n "$CUSTOM_APP3_BRANCH" ]; then
  bench get-app --branch=${CUSTOM_APP3_BRANCH} --resolve-deps ${CUSTOM_APP3_NAME} ${CUSTOM_APP3_REPO}
fi