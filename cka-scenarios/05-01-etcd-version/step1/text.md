Find the Pod that runs etcd. Inspect it and determine the etcd version.

Write only the version (for example `3.5.16` or `v3.5.16`) to `/root/etcd-version.txt`.

## Details

The etcd process is a static Pod in `kube-system`. Its name starts with `etcd-`. The container image tag is the version the check compares against your file. You can also exec `etcdctl version` inside that Pod.

Write a single version token. `3.5.16` and `v3.5.16` are both accepted. A tag such as `3.5.16-0` matches a file that contains `3.5.16`.

## Finished when

`/root/etcd-version.txt` matches the etcd container image tag.

Docs: https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/
