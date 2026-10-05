#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

[[ -s /root/etcd-version.txt ]] || fail "missing /root/etcd-version.txt"
got=$(tr -d '[:space:]' < /root/etcd-version.txt)
etcd=$(kubectl get pods -n kube-system --no-headers | awk '/^etcd-/{print $1; exit}')
[[ -n "$etcd" ]] || fail "etcd Pod not found"
image=$(kubectl get pod -n kube-system "$etcd" -o jsonpath='{.spec.containers[0].image}')
tag=${image##*:}
tag=${tag#v}
got=${got#v}
if [[ "$got" != "$tag" && "$tag" != "$got"* && "$got" != "$tag"* ]]; then
  fail "expected etcd version $tag from $image, file contains $got"
fi
echo OK
