#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

[[ -s /root/rendered.yaml ]] || fail "missing /root/rendered.yaml"
grep -q 'namespace: t012' /root/rendered.yaml || fail "rendered manifest has no namespace t012"
grep -q 'name: nginx' /root/rendered.yaml || fail "rendered manifest has no Pod nginx"
grep -q 'nginx:1.27-alpine' /root/rendered.yaml || fail "rendered manifest has the wrong image"
echo OK
