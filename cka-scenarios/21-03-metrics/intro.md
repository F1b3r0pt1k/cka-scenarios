This lab runs on a two-node kubeadm cluster.

| Host | Role | IP |
| --- | --- | --- |
| `controlplane` | control plane | 172.30.1.2 |
| `node01` | worker | 172.30.2.2 |

Use the **controlplane** terminal unless a step tells you to switch hosts. Ordinary Pods schedule onto `node01`. Switch to the **node01** terminal when you need to run commands on the worker itself.

Metrics Server is installed. Namespace `stress` contains three Pods that allocate different amounts of memory. `kubectl top` may take a minute to show numbers after the Pods start.
