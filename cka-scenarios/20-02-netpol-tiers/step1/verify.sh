#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl get netpol database-policy -n shop >/dev/null || fail "database-policy missing"
kubectl get netpol backend-policy -n shop >/dev/null || fail "backend-policy missing"
deny=$(kubectl get netpol -n shop -o jsonpath='{range .items[*]}{.metadata.name}{" "}{.spec.podSelector}{" "}{.spec.policyTypes}{"\n"}{end}')
echo "$deny" | grep -q 'Ingress' || fail "no ingress policy found"
kubectl exec -n shop frontend -- wget -q -O- -T 8 http://backend >/dev/null || fail "frontend cannot reach backend"
if kubectl exec -n shop frontend -- nc -z -w 4 database 6379; then
  fail "frontend can reach the database"
fi
kubectl exec -n shop backend -- nc -z -w 4 database 6379 || fail "backend cannot reach the database"
echo OK
