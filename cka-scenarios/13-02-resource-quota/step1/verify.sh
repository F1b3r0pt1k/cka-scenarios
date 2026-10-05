#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl get quota app -n quota-demo >/dev/null || fail "quota missing"
grep -qi 'exceeded quota' /root/quota-error.txt || fail "quota-error.txt should contain the rejection"
kubectl get pod too-big -n quota-demo >/dev/null 2>&1 && fail "too-big should not exist"
kubectl wait --for=condition=Ready pod/fits -n quota-demo --timeout=120s || fail "fits is not Ready"
mem=$(kubectl get pod fits -n quota-demo -o jsonpath='{.spec.containers[0].resources.requests.memory}')
[[ "$mem" == "200Mi" ]] || fail "fits memory request is $mem"
echo OK
