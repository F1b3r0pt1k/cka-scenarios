#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl wait --for=condition=Ready pod/recorder --timeout=90s || fail "recorder is not Ready"
got=$(kubectl exec recorder -- cat /var/log/app/marker.txt 2>/dev/null || true)
echo "$got" | grep -q started || fail "marker file is '$got'"
kubectl logs recorder | grep -q WRITE_OK || fail "logs do not contain WRITE_OK"
echo OK
