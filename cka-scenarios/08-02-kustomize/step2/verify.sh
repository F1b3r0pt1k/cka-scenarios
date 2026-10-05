#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl get pod nginx >/dev/null 2>&1 && fail "Pod nginx still exists"
kubectl get configmap logs-config >/dev/null 2>&1 && fail "ConfigMap logs-config still exists"
grep -q '/etc/logs/traffic-log.txt' /root/manifests/configmap.yaml || fail "manifest was not updated on disk"
echo OK
