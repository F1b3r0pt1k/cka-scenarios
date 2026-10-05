#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl get netpol -n team-alpha --no-headers | grep -q . || fail "no NetworkPolicy in team-alpha"
kubectl get netpol -n team-beta --no-headers | grep -q . || fail "no NetworkPolicy in team-beta"
kubectl exec -n team-alpha alpha-app -- wget -q -O- -T 8 http://beta-app.team-beta.svc | grep -q "Welcome to nginx" || fail "alpha cannot reach beta"
if kubectl exec -n team-alpha alpha-app -- wget -q -O- -T 5 http://1.1.1.1; then
  fail "alpha can still reach the public internet"
fi
if kubectl exec outsider -- wget -q -O- -T 5 http://beta-app.team-beta.svc; then
  fail "outsider can still reach beta"
fi
echo OK
