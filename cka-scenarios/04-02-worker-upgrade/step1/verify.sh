#!/bin/bash
fail() { echo "FAIL: $*" >&2; exit 1; }

[[ -s /root/cluster-version.txt ]] || fail "missing /root/cluster-version.txt"
grep -q controlplane /root/cluster-version.txt || fail "file does not mention controlplane"
grep -q node01 /root/cluster-version.txt || fail "file does not mention node01"
grep -Eq 'v?[0-9]+\.[0-9]+\.[0-9]+' /root/cluster-version.txt || fail "file does not contain a version"
echo OK
