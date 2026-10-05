This lab runs on a two-node kubeadm cluster.

| Host | Role | IP |
| --- | --- | --- |
| `controlplane` | control plane | 172.30.1.2 |
| `node01` | worker | 172.30.2.2 |

Use the **controlplane** terminal unless a step tells you to switch hosts. Ordinary Pods schedule onto `node01`.

Pod `recorder` is already running. Its command writes `/var/log/app/marker.txt` and then sleeps. The write is failing. The log line tells you which outcome you got.

Fix the Pod spec so the write succeeds. Replacing the Pod is expected. A directory created by hand inside the container disappears when you replace the Pod, so make the path work from the manifest.
