#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

[[ -s /opt/etcd.bak ]] || fail "/opt/etcd.bak is missing or empty"
[[ -d /var/bak ]] || fail "/var/bak does not exist"
if ! find /var/bak -type d -name member | grep -q .; then
  fail "/var/bak does not contain restored etcd member data"
fi
echo OK
