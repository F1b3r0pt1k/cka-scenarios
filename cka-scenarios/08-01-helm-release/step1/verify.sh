#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

helm status frontend -n monitoring >/dev/null || fail "Helm release frontend is not installed"
kubectl get svc -n monitoring -o name | grep -q . || fail "no Services in monitoring"
echo OK
