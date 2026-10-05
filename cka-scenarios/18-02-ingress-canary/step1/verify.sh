#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl rollout status deploy/blue -n production --timeout=150s || fail "blue not ready"
kubectl rollout status deploy/green -n production --timeout=150s || fail "green not ready"
main=$(kubectl get ingress app-main -n production -o jsonpath='{.spec.rules[0].http.paths[0].backend.service.name}')
[[ "$main" == "blue" ]] || fail "main backend is $main"
can=$(kubectl get ingress app-canary -n production -o jsonpath='{.spec.rules[0].http.paths[0].backend.service.name}')
[[ "$can" == "green" ]] || fail "canary backend is $can"
flag=$(kubectl get ingress app-canary -n production -o jsonpath='{.metadata.annotations.nginx\.ingress\.kubernetes\.io/canary}')
weight=$(kubectl get ingress app-canary -n production -o jsonpath='{.metadata.annotations.nginx\.ingress\.kubernetes\.io/canary-weight}')
[[ "$flag" == "true" ]] || fail "canary annotation is $flag"
[[ "$weight" == "20" ]] || fail "canary weight is $weight"
host=$(kubectl get ingress app-main -n production -o jsonpath='{.spec.rules[0].host}')
[[ "$host" == "app.production.com" ]] || fail "host is $host"
echo OK
