This lab runs on a two-node kubeadm cluster.

| Host | Role | IP |
| --- | --- | --- |
| `controlplane` | control plane | 172.30.1.2 |
| `node01` | worker | 172.30.2.2 |

Use the **controlplane** terminal unless a step tells you to switch hosts. Ordinary Pods schedule onto `node01`.

Both applications stay on ClusterIP. The frontend resolves the database through the Service DNS name.
