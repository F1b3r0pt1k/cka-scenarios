#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl get clusterrole deployment-modify >/dev/null || fail "deployment-modify missing"
label=$(kubectl get clusterrole deployment-modify -o jsonpath='{.metadata.labels.rbac\.example\.com/aggregate}')
[[ "$label" == "true" ]] || fail "deployment-modify is missing the aggregate label"
verbs=$(kubectl get clusterrole deployment-modify -o jsonpath='{.rules[0].verbs[*]}')
for v in create delete patch update; do
  echo "$verbs" | grep -qw "$v" || fail "missing verb $v"
done
ok=0
for _ in $(seq 1 20); do
  resources=$(kubectl get clusterrole combined -o jsonpath='{range .rules[*].resources[*]}{.}{"\n"}{end}')
  if echo "$resources" | grep -qx deployments; then
    ok=1
    break
  fi
  sleep 1
done
[[ "$ok" == "1" ]] || fail "combined did not aggregate deployment-modify"
ans=$(tr -d '[:space:]' < /root/watch-deployments.txt)
[[ "$ans" == "no" ]] || fail "watch-deployments.txt should contain no"
live=$(kubectl auth can-i watch deployments -n production --as=devuser)
[[ "$live" == "no" ]] || fail "devuser unexpectedly can watch deployments in production"
echo OK
