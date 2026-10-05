#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl wait --for=condition=Ready pod/loop -n web --timeout=90s || fail "loop is not Running"
cmd=$(kubectl get pod loop -n web -o jsonpath='{.spec.containers[0].command}' ; kubectl get pod loop -n web -o jsonpath='{.spec.containers[0].args}')
echo "$cmd" | grep -q date || fail "command does not print the date: $cmd"
echo "$cmd" | grep -Eq 'while|sleep' || fail "command does not look like a loop: $cmd"
echo OK
