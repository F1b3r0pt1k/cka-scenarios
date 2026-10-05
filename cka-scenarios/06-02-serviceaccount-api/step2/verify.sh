#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl wait --for=condition=Ready pod/operator -n apps --timeout=120s || fail "operator Pod is not Ready"
sa=$(kubectl get pod operator -n apps -o jsonpath='{.spec.serviceAccountName}')
[[ "$sa" == "api-access" ]] || fail "operator is not using api-access"
kubectl get pod disposable -n temporary >/dev/null || fail "disposable Pod is missing"
list=$(tr -d '[:space:]' < /root/list-pods.status)
del=$(tr -d '[:space:]' < /root/delete-pod.status)
[[ "$list" == "200" ]] || fail "list status should be 200, got $list"
[[ "$del" == "403" ]] || fail "delete status should be 403, got $del"
echo OK
