This lab runs on a two-node kubeadm cluster.

| Host | Role | IP |
| --- | --- | --- |
| `controlplane` | control plane | 172.30.1.2 |
| `node01` | worker | 172.30.2.2 |

Use the **controlplane** terminal unless a step tells you to switch hosts. Ordinary Pods schedule onto `node01`.

ingress-nginx is installed. Canary behavior comes from controller annotations: `nginx.ingress.kubernetes.io/canary` and `nginx.ingress.kubernetes.io/canary-weight`.

The controller Service is `ingress-nginx-controller` in namespace `ingress-nginx`.
