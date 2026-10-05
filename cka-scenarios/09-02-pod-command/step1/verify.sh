#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl get pod loop -n web >/dev/null || fail "Pod loop missing"
phase=$(kubectl get pod loop -n web -o jsonpath='{.status.phase}')
[[ "$phase" == "Succeeded" ]] || fail "phase is $phase, expected Succeeded"
echo OK
