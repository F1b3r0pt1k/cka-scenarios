This lab runs on a two-node kubeadm cluster.

| Host | Role | IP |
| --- | --- | --- |
| `controlplane` | control plane | 172.30.1.2 |
| `node01` | worker | 172.30.2.2 |

Use the **controlplane** terminal unless a step tells you to switch hosts. Ordinary Pods schedule onto `node01`. The control plane is tainted.

Label `node01` with `color=green` and `controlplane` with `color=red`. The control plane taint still blocks ordinary Pods, so a Pod that may run on either color will still land on the worker unless you tolerate the control plane taint.

`nodeSelector` is immutable. Replace the Pod when you switch to affinity.
