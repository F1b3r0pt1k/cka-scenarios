#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl wait --for=condition=Ready pod/nginx -n web --timeout=120s || fail "nginx is not Ready"
url=$(kubectl get pod nginx -n web -o jsonpath='{.spec.containers[0].env[?(@.name=="DB_URL")].value}')
user=$(kubectl get pod nginx -n web -o jsonpath='{.spec.containers[0].env[?(@.name=="DB_USERNAME")].value}')
[[ "$url" == "postgresql://mydb:5432" ]] || fail "DB_URL is $url"
[[ "$user" == "admin" ]] || fail "DB_USERNAME is $user"
echo OK
