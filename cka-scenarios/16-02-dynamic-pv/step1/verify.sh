#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

phase=$(kubectl get pvc db-pvc -n persistence -o jsonpath='{.status.phase}')
[[ "$phase" == "Pending" ]] || fail "PVC phase is $phase, expected Pending"
sc=$(kubectl get pvc db-pvc -n persistence -o jsonpath='{.spec.storageClassName}')
[[ "$sc" == "local-path" ]] || fail "storage class is $sc"
count=$(kubectl get pv -o name 2>/dev/null | wc -l | tr -d ' ')
[[ "$count" == "0" ]] || fail "a PersistentVolume already exists"
echo OK
