#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl get pod nginx >/dev/null || fail "Pod nginx missing"
img=$(kubectl get pod nginx -o jsonpath='{.spec.containers[0].image}')
[[ "$img" == "nginx:1.27-alpine" ]] || fail "image is $img"
val=$(kubectl get configmap logs-config -o jsonpath='{.data.dir}')
[[ "$val" == "/etc/logs/traffic.log" ]] || fail "dir is $val"
echo OK
