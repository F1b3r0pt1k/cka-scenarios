This lab runs on a two-node kubeadm cluster.

| Host | Role | IP |
| --- | --- | --- |
| `controlplane` | control plane | 172.30.1.2 |
| `node01` | worker | 172.30.2.2 |

Use the **controlplane** terminal unless a step tells you to switch hosts. Ordinary Pods schedule onto `node01`. Switch to the **node01** terminal when you need to run commands on the worker itself.

`node01` has been left unable to run new Pods. More than one thing is wrong. Look at node status, taints, and the kubelet on the worker.

The **node01** terminal is the shell on that machine. You do not need to copy kubeconfig there for `systemctl`.
