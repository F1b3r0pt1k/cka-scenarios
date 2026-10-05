## Exam desktop

This scenario uses Killercoda's Linux Foundation exam desktop when that view is available.

Wait until the preparation terminal prints `Lab environment is ready` before you depend on preinstalled objects. That shell stays open. Do not expect it to exit.

Open **Terminal Emulator** on the desktop to run `kubectl`. Open **Firefox on the desktop** for the Kubernetes documentation. The browser on your own computer is not the one you get in the exam.

Inside the desktop terminal, copy with Ctrl+Shift+C and paste with Ctrl+Shift+V. `k` is an alias for `kubectl`. `$do` expands to `--dry-run=client -o yaml`. `$now` expands to `--force --grace-period=0`. Vim is set to two-space indentation.

## Cluster

| Host | Role | IP |
| --- | --- | --- |
| `controlplane` | control plane | 172.30.1.2 |
| `node01` | worker | 172.30.2.2 |

Stay on **controlplane** unless a step tells you to use `node01`. The control plane taint is `node-role.kubernetes.io/control-plane:NoSchedule`, so ordinary Pods are scheduled onto `node01`. From the control plane, `ssh node01` opens a shell on the worker. The desktop may also show both hosts in the Killercoda host list.


A Deployment manifest is saved at `/root/fix-me-deployment.yaml`. It is rejected by the API server until the selector and the Pod labels agree.
