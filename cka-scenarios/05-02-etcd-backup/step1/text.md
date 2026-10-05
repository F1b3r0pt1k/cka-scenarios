Save an etcd snapshot to `/opt/etcd.bak`.

Restore that snapshot into the data directory `/var/bak`.

Do not change the static Pod to point etcd at `/var/bak`.

## Details

`etcdctl` and, when the image includes it, `etcdutl` are already on the PATH. Talk to etcd over HTTPS on `127.0.0.1:2379`. The CA, cert, and key are:

- `/etc/kubernetes/pki/etcd/ca.crt`
- `/etc/kubernetes/pki/etcd/server.crt`
- `/etc/kubernetes/pki/etcd/server.key`

Set `ETCDCTL_API=3`. Snapshot to `/opt/etcd.bak`. Restore into a new data directory `/var/bak`. `etcdctl snapshot restore` or `etcdutl snapshot restore` both produce a `member` directory under that path.

Do not edit the etcd static Pod manifest and do not point the live server at `/var/bak`. That would replace the cluster database.

## Finished when

- `/opt/etcd.bak` exists and is not empty.
- `/var/bak` contains a restored `member` directory.

Docs: https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/#backing-up-an-etcd-cluster
