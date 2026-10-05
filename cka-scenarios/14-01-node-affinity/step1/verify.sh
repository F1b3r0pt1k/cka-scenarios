#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

green=$(kubectl get node node01 -o jsonpath='{.metadata.labels.color}')
red=$(kubectl get node controlplane -o jsonpath='{.metadata.labels.color}')
[[ "$green" == "green" ]] || fail "node01 color is $green"
[[ "$red" == "red" ]] || fail "controlplane color is $red"
kubectl wait --for=condition=Ready pod/web --timeout=120s || fail "web is not Ready"
node=$(kubectl get pod web -o jsonpath='{.spec.nodeName}')
color=$(kubectl get node "$node" -o jsonpath='{.metadata.labels.color}')
[[ "$color" == "green" ]] || fail "web is on $node (color=$color)"
sel=$(kubectl get pod web -o jsonpath='{.spec.nodeSelector.color}')
[[ "$sel" == "green" ]] || fail "nodeSelector color is $sel"
echo OK
