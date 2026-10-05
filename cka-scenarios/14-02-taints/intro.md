This lab runs on a two-node kubeadm cluster.

| Host | Role | IP |
| --- | --- | --- |
| `controlplane` | control plane | 172.30.1.2 |
| `node01` | worker | 172.30.2.2 |

Use the **controlplane** terminal unless a step tells you to switch hosts. Ordinary Pods schedule onto `node01`. The control plane is tainted.

Tolerations cannot be edited on an existing Pod. When a step asks you to add one, replace the Pod.

A `NoExecute` taint evicts Pods that do not tolerate it. Removing the taint does not delete a Pod that is already running.
