This lab runs on a two-node kubeadm cluster.

| Host | Role | IP |
| --- | --- | --- |
| `controlplane` | control plane | 172.30.1.2 |
| `node01` | worker | 172.30.2.2 |

Use the **controlplane** terminal unless a step tells you to switch hosts. Ordinary Pods schedule onto `node01`.

Namespaces `team-alpha` (label `team=alpha`) and `team-beta` (label `team=beta`) already exist.

`alpha-app` is a busybox Pod in `team-alpha`. `beta-app` is an nginx Pod and Service in `team-beta`. `outsider` is a busybox Pod in `default`.

The cluster CNI enforces NetworkPolicy. DNS is CoreDNS in `kube-system`; if you deny all egress, allow TCP and UDP port 53 or Service DNS will fail.
