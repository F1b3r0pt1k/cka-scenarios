#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

node=$(tr -d '[:space:]' < /root/pod-node.txt)
taint=$(kubectl get node "$node" -o jsonpath='{range .spec.taints[*]}{.key}={.value}:{.effect}{"\n"}{end}')
echo "$taint" | grep -qx 'exclusive=yes:NoExecute' || fail "expected taint not found on $node: $taint"
kubectl get pod web >/dev/null 2>&1 && fail "web should have been evicted"
echo OK
