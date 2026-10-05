#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl wait --for=condition=Ready node/node01 --timeout=90s || fail "node01 is not Ready"
unsched=$(kubectl get node node01 -o jsonpath='{.spec.unschedulable}')
[[ "$unsched" == "true" ]] && fail "node01 is still cordoned"
kubectl wait --for=condition=Ready pod/node-check --timeout=120s || fail "node-check is not Ready"
node=$(kubectl get pod node-check -o jsonpath='{.spec.nodeName}')
[[ "$node" == "node01" ]] || fail "node-check is on $node"
echo OK
