#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl rollout status deploy/database --timeout=120s || fail "database not ready"
kubectl rollout status deploy/frontend --timeout=120s || fail "frontend not ready"
typ=$(kubectl get svc database-service -o jsonpath='{.spec.type}')
port=$(kubectl get svc database-service -o jsonpath='{.spec.ports[0].port}')
[[ "$typ" == "ClusterIP" && "$port" == "3306" ]] || fail "database-service is $typ:$port"
sel=$(kubectl get svc database-service -o jsonpath='{.spec.selector.app}')
[[ "$sel" == "database" ]] || fail "selector is $sel"
ep=$(kubectl get endpoints database-service -o jsonpath='{.subsets[0].addresses[0].ip}')
[[ -n "$ep" ]] || fail "database-service has no endpoints"
pod=$(kubectl get pods -l app=frontend -o jsonpath='{.items[0].metadata.name}')
ok=0
for _ in $(seq 1 15); do
  if kubectl logs "$pod" | grep -q connected; then
    ok=1
    break
  fi
  sleep 2
done
[[ "$ok" == "1" ]] || fail "frontend logs do not show a successful connection"
echo OK
