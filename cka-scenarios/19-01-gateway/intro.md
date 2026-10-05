This lab runs on a two-node kubeadm cluster.

| Host | Role | IP |
| --- | --- | --- |
| `controlplane` | control plane | 172.30.1.2 |
| `node01` | worker | 172.30.2.2 |

Use the **controlplane** terminal unless a step tells you to switch hosts. Ordinary Pods schedule onto `node01`.

Gateway API CRDs and NGINX Gateway Fabric are installed. The GatewayClass name is `nginx`.

Create the workloads yourself. A Gateway without an accepted HTTPRoute is not finished.
