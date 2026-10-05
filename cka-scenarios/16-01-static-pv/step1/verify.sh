#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

phase=$(kubectl get pv logs-pv -o jsonpath='{.status.phase}')
[[ "$phase" == "Bound" ]] || fail "PV phase is $phase"
claim=$(kubectl get pv logs-pv -o jsonpath='{.spec.claimRef.name}')
[[ "$claim" == "logs-pvc" ]] || fail "PV is bound to $claim"
modes=$(kubectl get pv logs-pv -o jsonpath='{.spec.accessModes[*]}')
echo "$modes" | grep -qw ReadWriteOnce || fail "missing RWO"
echo "$modes" | grep -qw ReadOnlyMany || fail "missing ROX"
cap=$(kubectl get pv logs-pv -o jsonpath='{.spec.capacity.storage}')
[[ "$cap" == "5Gi" ]] || fail "capacity is $cap"
req=$(kubectl get pvc logs-pvc -o jsonpath='{.spec.resources.requests.storage}')
[[ "$req" == "2Gi" ]] || fail "PVC request is $req"
kubectl wait --for=condition=Ready pod/nginx --timeout=120s || fail "nginx Pod not Ready"
got=$(kubectl exec nginx -- cat /var/log/nginx/my-nginx.log)
echo "$got" | grep -q 'hello from nginx' || fail "log contents '$got'"
echo OK
