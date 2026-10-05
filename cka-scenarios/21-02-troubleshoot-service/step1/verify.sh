#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

sel=$(kubectl get svc web -n shop -o jsonpath='{.spec.selector.app}')
[[ "$sel" == "web" ]] || fail "selector app is $sel"
target=$(kubectl get svc web -n shop -o jsonpath='{.spec.ports[0].targetPort}')
[[ "$target" == "80" ]] || fail "targetPort is $target"
ep=$(kubectl get endpoints web -n shop -o jsonpath='{.subsets[0].addresses[*].ip}')
set -- $ep
[[ "$#" -ge 1 ]] || fail "service has no endpoints"
kubectl delete pod curl-check -n shop --ignore-not-found
kubectl run curl-check -n shop --restart=Never --image=busybox:1.36 --command -- wget -q -O- -T 8 http://web
for _ in $(seq 1 25); do
  phase=$(kubectl get pod curl-check -n shop -o jsonpath='{.status.phase}' 2>/dev/null || true)
  [[ "$phase" == "Succeeded" || "$phase" == "Failed" ]] && break
  sleep 1
done
kubectl logs curl-check -n shop | grep -q "Welcome to nginx" || fail "wget did not reach nginx"
kubectl delete pod curl-check -n shop --ignore-not-found
echo OK
