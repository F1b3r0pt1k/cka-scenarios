This lab runs on a two-node kubeadm cluster.

| Host | Role | IP |
| --- | --- | --- |
| `controlplane` | control plane | 172.30.1.2 |
| `node01` | worker | 172.30.2.2 |

Use the **controlplane** terminal unless a step tells you to switch hosts. Ordinary Pods schedule onto `node01`.

Namespace `shop` contains Pods `frontend` (`tier=frontend`), `backend` (`tier=backend`, busybox httpd on port 80), and `database` (`tier=database`, Redis on port 6379). Services use those same names and ports.

You will add the policies. A default deny for ingress in the namespace blocks every Pod until a more specific policy allows traffic.
