Run `kubeadm upgrade plan` and save stdout and stderr to `/root/upgrade-plan.txt`.

The command reports whether the control plane is already at the newest available version. Keep the saved output for the check.

## Details

`kubeadm upgrade plan` prints to stdout and can also print to stderr. Save both:

`kubeadm upgrade plan > /root/upgrade-plan.txt 2>&1`

On this lab the cluster is often already at the newest packaged version. That is a successful result. Do not try to change the package version.

## Finished when

`/root/upgrade-plan.txt` is non-empty and contains the upgrade-plan output.

Docs: https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/
