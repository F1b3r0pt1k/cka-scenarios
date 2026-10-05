#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

kubectl get crd backups.example.com >/dev/null || fail "Backup CRD missing"
kubectl get backup nginx-backup >/dev/null || fail "nginx-backup missing"
cron=$(kubectl get backup nginx-backup -o jsonpath='{.spec.cronExpression}')
pod=$(kubectl get backup nginx-backup -o jsonpath='{.spec.podName}')
path=$(kubectl get backup nginx-backup -o jsonpath='{.spec.path}')
[[ "$cron" == "0 0 * * *" ]] || fail "cronExpression is $cron"
[[ "$pod" == "nginx" ]] || fail "podName is $pod"
[[ "$path" == "/usr/local/nginx" ]] || fail "path is $path"
echo OK
