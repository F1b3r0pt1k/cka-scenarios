#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl get crd databases.platform.example.com >/dev/null || fail "CRD was not installed"
kind=$(kubectl get databases.platform.example.com sample -o jsonpath='{.kind}')
[[ "$kind" == "Database" ]] || fail "sample is not a Database"
ver=$(kubectl get database sample -o jsonpath='{.spec.version}')
stor=$(kubectl get database sample -o jsonpath='{.spec.storage}')
[[ "$ver" == "7" ]] || fail "spec.version is $ver"
[[ "$stor" == "10Gi" ]] || fail "spec.storage is $stor"
echo OK
