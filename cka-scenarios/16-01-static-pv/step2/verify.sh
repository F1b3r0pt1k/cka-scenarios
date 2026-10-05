#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl wait --for=condition=Ready pod/nginx --timeout=120s || fail "nginx Pod not Ready"
got=$(kubectl exec nginx -- cat /var/log/nginx/my-nginx.log)
echo "$got" | grep -q 'hello from nginx' || fail "file did not survive: '$got'"
echo OK
