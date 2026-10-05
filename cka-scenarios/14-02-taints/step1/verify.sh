#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl wait --for=condition=Ready pod/web --timeout=120s || fail "web is not Ready"
node=$(kubectl get pod web -o jsonpath='{.spec.nodeName}')
saved=$(tr -d '[:space:]' < /root/pod-node.txt)
[[ "$saved" == "$node" ]] || fail "pod-node.txt says $saved but Pod is on $node"
echo OK
