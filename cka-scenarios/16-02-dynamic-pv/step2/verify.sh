#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl wait --for=condition=Ready pod/app -n persistence --timeout=180s || fail "app is not Ready"
phase=$(kubectl get pvc db-pvc -n persistence -o jsonpath='{.status.phase}')
[[ "$phase" == "Bound" ]] || fail "PVC phase is $phase"
pv=$(kubectl get pvc db-pvc -n persistence -o jsonpath='{.spec.volumeName}')
[[ -n "$pv" ]] || fail "no volume name on the claim"
kubectl get pv "$pv" >/dev/null || fail "PV $pv missing"
got=$(kubectl exec -n persistence app -- cat /mnt/data/test.db)
echo "$got" | grep -q ok || fail "test.db contents '$got'"
echo OK
