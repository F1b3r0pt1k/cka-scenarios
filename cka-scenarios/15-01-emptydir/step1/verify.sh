#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl wait --for=condition=Ready pod/share --timeout=120s || fail "share is not Ready"
n=$(kubectl get pod share -o jsonpath='{.spec.containers[*].name}')
echo "$n" | grep -qw first || fail "missing container first"
echo "$n" | grep -qw second || fail "missing container second"
a=$(kubectl get pod share -o jsonpath='{.spec.containers[?(@.name=="first")].volumeMounts[?(@.mountPath=="/etc/a")].name}')
b=$(kubectl get pod share -o jsonpath='{.spec.containers[?(@.name=="second")].volumeMounts[?(@.mountPath=="/etc/b")].name}')
[[ -n "$a" && "$a" == "$b" ]] || fail "containers do not share the volume"
got=$(kubectl exec share -c second -- cat /etc/b/data/hello.txt)
echo "$got" | grep -q 'Hello World' || fail "file contents are '$got'"
echo OK
