This lab runs on a two-node kubeadm cluster.

| Host | Role | IP |
| --- | --- | --- |
| `controlplane` | control plane | 172.30.1.2 |
| `node01` | worker | 172.30.2.2 |

Use the **controlplane** terminal unless a step tells you to switch hosts. Ordinary Pods schedule onto `node01`.

NGINX Gateway Fabric is installed. GatewayClass: `nginx`.

A route in another namespace can attach only when the Gateway allows it and a ReferenceGrant in the Gateway's namespace allows that attachment.
