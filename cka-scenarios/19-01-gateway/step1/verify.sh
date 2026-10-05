#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl rollout status deploy/web-app --timeout=150s || fail "web-app not ready"
kubectl rollout status deploy/api-app --timeout=150s || fail "api-app not ready"
class=$(kubectl get gateway main-gateway -o jsonpath='{.spec.gatewayClassName}')
[[ "$class" == "nginx" ]] || fail "gateway class is $class"
host=$(kubectl get gateway main-gateway -o jsonpath='{.spec.listeners[0].hostname}')
port=$(kubectl get gateway main-gateway -o jsonpath='{.spec.listeners[0].port}')
proto=$(kubectl get gateway main-gateway -o jsonpath='{.spec.listeners[0].protocol}')
[[ "$host" == "example.local" && "$port" == "80" && "$proto" == "HTTP" ]] || fail "listener is $proto $host:$port"
parent=$(kubectl get httproute app-routes -o jsonpath='{.spec.parentRefs[0].name}')
[[ "$parent" == "main-gateway" ]] || fail "parentRef is $parent"
paths=$(kubectl get httproute app-routes -o jsonpath='{range .spec.rules[*]}{.matches[0].path.type} {.matches[0].path.value}={.backendRefs[0].name}{"\n"}{end}')
echo "$paths" | grep -qx 'PathPrefix /web=web-app' || fail "missing /web rule: $paths"
echo "$paths" | grep -qx 'PathPrefix /api=api-app' || fail "missing /api rule: $paths"
echo OK
