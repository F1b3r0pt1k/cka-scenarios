#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl wait --for=condition=Ready pod/web --timeout=120s || fail "web is not Ready"
node=$(kubectl get pod web -o jsonpath='{.spec.nodeName}')
color=$(kubectl get node "$node" -o jsonpath='{.metadata.labels.color}')
[[ "$color" == "green" || "$color" == "red" ]] || fail "web is on color $color"
expr=$(kubectl get pod web -o jsonpath='{.spec.affinity.nodeAffinity.requiredDuringSchedulingIgnoredDuringExecution.nodeSelectorTerms[0].matchExpressions[0].key}')
op=$(kubectl get pod web -o jsonpath='{.spec.affinity.nodeAffinity.requiredDuringSchedulingIgnoredDuringExecution.nodeSelectorTerms[0].matchExpressions[0].operator}')
vals=$(kubectl get pod web -o jsonpath='{.spec.affinity.nodeAffinity.requiredDuringSchedulingIgnoredDuringExecution.nodeSelectorTerms[0].matchExpressions[0].values[*]}')
[[ "$expr" == "color" && "$op" == "In" ]] || fail "affinity expression is $expr $op"
echo "$vals" | grep -qw green || fail "affinity values missing green: $vals"
echo "$vals" | grep -qw red || fail "affinity values missing red: $vals"
echo OK
