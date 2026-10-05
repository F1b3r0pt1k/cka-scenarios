#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl rollout status deploy/webapp --timeout=150s || fail "webapp is not ready"
ready=$(kubectl get deploy webapp -o jsonpath='{.status.readyReplicas}')
[[ "$ready" == "3" ]] || fail "ready replicas $ready"
typ=$(kubectl get svc webapp-service -o jsonpath='{.spec.type}')
[[ "$typ" == "NodePort" ]] || fail "service type is $typ"
web=$(kubectl get svc webapp-service -o jsonpath='{.spec.ports[?(@.name=="web")].nodePort}')
[[ "$web" == "30080" ]] || fail "web nodePort is $web"
metrics=$(kubectl get svc webapp-service -o jsonpath='{.spec.ports[?(@.name=="metrics")].port}')
[[ "$metrics" == "9090" ]] || fail "metrics port is $metrics"
ep=$(kubectl get endpoints webapp-service -o jsonpath='{.subsets[0].addresses[*].ip}')
set -- $ep
[[ "$#" -ge 3 ]] || fail "expected 3 endpoints, got $ep"
curl -fsS --max-time 8 http://172.30.2.2:30080 | grep -q "Welcome to nginx" || fail "node port did not return nginx"
echo OK
