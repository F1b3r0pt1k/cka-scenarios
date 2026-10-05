#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl get secret db-credentials >/dev/null || fail "Secret missing"
kubectl wait --for=condition=Ready pod/backend --timeout=120s || fail "backend is not Ready"
got=$(kubectl exec backend -- printenv DB_PASSWORD)
[[ "$got" == "passwd" ]] || fail "DB_PASSWORD is not the expected value"
ref=$(kubectl get pod backend -o jsonpath='{.spec.containers[0].env[?(@.name=="DB_PASSWORD")].valueFrom.secretKeyRef.name}')
key=$(kubectl get pod backend -o jsonpath='{.spec.containers[0].env[?(@.name=="DB_PASSWORD")].valueFrom.secretKeyRef.key}')
[[ "$ref" == "db-credentials" && "$key" == "db-password" ]] || fail "env var is not sourced from the Secret key"
echo OK
