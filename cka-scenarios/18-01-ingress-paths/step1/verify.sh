#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl rollout status deploy/frontend -n webapp --timeout=150s || fail "frontend not ready"
kubectl rollout status deploy/api -n webapp --timeout=150s || fail "api not ready"
class=$(kubectl get ingress app -n webapp -o jsonpath='{.spec.ingressClassName}')
[[ "$class" == "nginx" ]] || fail "ingress class is $class"
host=$(kubectl get ingress app -n webapp -o jsonpath='{.spec.rules[0].host}')
[[ "$host" == "app.example.com" ]] || fail "host is $host"
paths=$(kubectl get ingress app -n webapp -o jsonpath='{range .spec.rules[0].http.paths[*]}{.path}={.backend.service.name}{"\n"}{end}')
echo "$paths" | grep -qx '/=frontend' || fail "missing / -> frontend: $paths"
echo "$paths" | grep -qx '/app=frontend' || fail "missing /app -> frontend: $paths"
echo "$paths" | grep -qx '/api=api' || fail "missing /api -> api: $paths"
ip=$(kubectl get svc ingress-nginx-controller -n ingress-nginx -o jsonpath='{.spec.clusterIP}')
curl -fsS --max-time 10 -H 'Host: app.example.com' "http://$ip/" | grep -q "Welcome to nginx" || fail "ingress / did not reach nginx"
echo OK
