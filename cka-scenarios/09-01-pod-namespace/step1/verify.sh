#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl get pod nginx -n web >/dev/null || fail "Pod missing"
port=$(kubectl get pod nginx -n web -o jsonpath='{.spec.containers[0].ports[0].containerPort}')
[[ "$port" == "80" ]] || fail "container port is $port"
img=$(kubectl get pod nginx -n web -o jsonpath='{.spec.containers[0].image}')
[[ "$img" == "nginx:1.27-alpine" ]] || fail "image is $img"
kubectl wait --for=condition=Ready pod/nginx -n web --timeout=120s || fail "nginx is not Ready"
ip=$(kubectl get pod nginx -n web -o jsonpath='{.status.podIP}')
kubectl delete pod curl-check -n web --ignore-not-found
kubectl run curl-check -n web --restart=Never --image=busybox:1.36 --command -- wget -q -O- -T 8 "http://$ip"
for _ in $(seq 1 20); do
  phase=$(kubectl get pod curl-check -n web -o jsonpath='{.status.phase}' 2>/dev/null || true)
  [[ "$phase" == "Succeeded" || "$phase" == "Failed" ]] && break
  sleep 1
done
kubectl logs curl-check -n web | grep -q "Welcome to nginx" || fail "could not fetch the nginx welcome page from $ip"
kubectl delete pod curl-check -n web --ignore-not-found
echo OK
