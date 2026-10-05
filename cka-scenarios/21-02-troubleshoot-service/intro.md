This lab runs on a two-node kubeadm cluster.

| Host | Role | IP |
| --- | --- | --- |
| `controlplane` | control plane | 172.30.1.2 |
| `node01` | worker | 172.30.2.2 |

Use the **controlplane** terminal unless a step tells you to switch hosts. Ordinary Pods schedule onto `node01`. Switch to the **node01** terminal when you need to run commands on the worker itself.

Namespace `shop` already contains Deployment `web` and Service `web`. A request to the Service does not reach nginx.

The manifests are also in `/root/broken-service.yaml` if you want to read the original objects. Fix the live Service. The Deployment image and labels are correct.
