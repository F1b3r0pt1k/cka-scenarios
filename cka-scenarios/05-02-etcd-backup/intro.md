This lab runs on a two-node kubeadm cluster.

| Host | Role | IP |
| --- | --- | --- |
| `controlplane` | control plane | 172.30.1.2 |
| `node01` | worker | 172.30.2.2 |

Use the **controlplane** terminal unless a step tells you to switch hosts. The worker is the node that accepts ordinary Pods. The control plane is tainted so it does not run application Pods.

`etcdctl` and `etcdutl` are installed on the control plane. API server certificates for etcd are under `/etc/kubernetes/pki/etcd`. The etcd endpoint listens on `https://127.0.0.1:2379`.

Take a snapshot, then restore it into a new directory. Leave the live etcd process on its current data directory so the cluster stays up.
